mvn -Dassembly.skipAssembly=true -DskipTests -Dmaven.javadoc.skip=true org.openrewrite.maven:rewrite-maven-plugin:run \
  -Drewrite.recipeArtifactCoordinates=software.amazon.awssdk:migration-tool:2.23.16-SNAPSHOT
  -Drewrite.activeRecipes=software.amazon.awssdk.UpgradeJavaSdk2
