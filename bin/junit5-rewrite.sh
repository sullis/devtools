MAVEN_OPTS="-Xms8g -Xmx8g" mvn -Dassembly.skipAssembly=true -DskipTests -Djacoco.skip -Dcheckstyle.skip -Dmaven.javadoc.skip=true clean install org.openrewrite.maven:rewrite-maven-plugin:run \
  -Drewrite.recipeArtifactCoordinates=org.openrewrite.recipe:rewrite-testing-frameworks:2.14.0 \
  -Drewrite.activeRecipes=org.openrewrite.java.testing.junit5.JUnit5BestPractices
