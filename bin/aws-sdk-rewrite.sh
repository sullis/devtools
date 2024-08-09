MAVEN_OPTS="-Xms8g -Xmx8g" mvn -Dassembly.skipAssembly=true -DskipTests -Djacoco.skip -Dcheckstyle.skip -Dmaven.javadoc.skip=true clean install org.openrewrite.maven:rewrite-maven-plugin:run \
  -Drewrite.recipeArtifactCoordinates=software.amazon.awssdk:v2-migration:2.27.2 \
  -Drewrite.activeRecipes=software.amazon.awssdk.v2migration.AwsSdkJavaV1ToV2
