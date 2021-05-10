lazy val root = Project(id = "portafolioService", base = file("."))
  .enablePlugins(JavaServerAppPackaging)
  .settings(
    organization := "eu.portavita",
    scalaVersion := "2.12.12",
    libraryDependencies ++= Dependencies.allDependencies
  )
  .settings(DockerImage.publishToRegistry)
  .settings(DependencyCheck.settings)

