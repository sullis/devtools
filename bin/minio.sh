#
# Minio on MacOS
# https://min.io/docs/minio/macos/index.html
#

mkdir -p ~/minio/data

minio server --address ":9990" --console-address ":9991" ~/minio/data
