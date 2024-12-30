MAVEN_OPTS="-Xms8g -Xmx8g" mvn -Dgpg.skip -Dassembly.skipAssembly=true -DskipTests -Djacoco.skip -Dcheckstyle.skip -Dmaven.javadoc.skip=true clean install org.openrewrite.maven:rewrite-maven-plugin:run \
  -Drewrite.recipeArtifactCoordinates=org.openrewrite.recipe:rewrite-migrate-java:2.31.0 \
  -Drewrite.activeRecipes=org.openrewrite.java.jspecify.MigrateToJspecify
