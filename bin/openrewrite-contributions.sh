#!/bin/sh
#
# Generate a Markdown report of merged pull requests authored by a GitHub user
# across every repository in a GitHub organization.
#
# Usage: ./openrewrite-contributions.sh [author] [org] [output-file]
#   author       GitHub login (default: the user authenticated with `gh`)
#   org          GitHub organization (default: openrewrite)
#   output-file  Markdown file to write (default: openrewrite-contributions.md)
#
# Requires: gh (authenticated via `gh auth login`) and jq.

set -eu

for cmd in gh jq; do
    if ! command -v "$cmd" >/dev/null 2>&1; then
        echo "error: '$cmd' is required but not installed" >&2
        exit 1
    fi
done

AUTHOR="${1:-$(gh api user --jq .login)}"
ORG="${2:-openrewrite}"
OUTPUT="${3:-openrewrite-contributions.md}"
TODAY="$(date +%Y-%m-%d)"

echo "Fetching merged PRs by @$AUTHOR in $ORG..." >&2

# GitHub search returns at most 1000 results.
gh search prs \
    --author "$AUTHOR" \
    --owner "$ORG" \
    --merged \
    --limit 1000 \
    --json repository,number,title,url,closedAt |
jq -r \
    --arg author "$AUTHOR" \
    --arg org "$ORG" \
    --arg today "$TODAY" '
    # GitHub heading anchor: lowercase, drop punctuation, spaces to hyphens.
    def anchor: ascii_downcase | gsub("[^a-z0-9 _-]"; "") | gsub(" "; "-");
    def esc: gsub("\\|"; "\\|");

    group_by(.repository.nameWithOwner)
    | sort_by(-length, .[0].repository.nameWithOwner) as $repos
    | ($repos | map(length) | add // 0) as $total
    | [
        "# My \($org) Contributions",
        "",
        "Merged pull requests authored by [@\($author)](https://github.com/\($author)) across the [\($org)](https://github.com/\($org)) organization.",
        "",
        "_Generated \($today) from the GitHub search API._",
        "",
        "## Summary",
        "",
        "- **Merged pull requests:** \($total)",
        "- **Repositories:** \($repos | length)",
        "",
        "| Repository | Merged PRs |",
        "|---|---:|",
        ($repos[] | .[0].repository.nameWithOwner as $r
            | "| [\($r)](#\($r | anchor)) | \(length) |"),
        ($repos[] | (
            "",
            "## \(.[0].repository.nameWithOwner)",
            "",
            "| Merged | PR | Title |",
            "|---|---|---|",
            (sort_by(.closedAt) | reverse | .[]
                | "| \(.closedAt[0:10]) | [#\(.number)](\(.url)) | \(.title | esc) |")
        ))
      ]
    | .[]
' > "$OUTPUT"

echo "Wrote $OUTPUT" >&2
