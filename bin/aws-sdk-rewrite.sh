MAVEN_OPTS="-Xms8g -Xmx8g" mvn -Dassembly.skipAssembly=true -DskipTests -Djacoco.skip -Dcheckstyle.skip -Dmaven.javadoc.skip=true clean install org.openrewrite.maven:rewrite-maven-plugin:run \
  -Drewrite.recipeArtifactCoordinates=software.amazon.awssdk:migration-tool:2.27.1 \
  -Drewrite.activeRecipes=software.amazon.awssdk.UpgradeJavaSdk2
