import sbt._

object Dependencies {
  lazy val allDependencies: Seq[ModuleID] =
    akkaDependencies ++
      testDependencies ++
      logbackDependencies ++
      json4sDependencies

  private lazy val akkaHttpVersion = "10.2.4"
  private lazy val akkaVersion = "2.6.8"
  private lazy val scaldiVersion = "0.5.8"

  private lazy val scalamockVersion: String = "4.1.0"
  private lazy val scalatestVersion: String = "3.0.5"
  private lazy val scalamockitoVersion = "1.15.0"
  private lazy val logbackVersion: String = "1.2.3"
  private lazy val json4sVersion = "3.6.7"

  val akkaDependencies = Seq(
    "com.typesafe.akka" %% "akka-actor-typed" % akkaVersion,
    "com.typesafe.akka" %% "akka-stream" % akkaVersion,
    "com.typesafe.akka" %% "akka-http" % akkaHttpVersion,
    "org.scaldi" %% "scaldi-akka" % scaldiVersion,
    "com.typesafe.akka" %% "akka-http-spray-json" % akkaHttpVersion
  )

  val json4sDependencies: Seq[ModuleID] = Seq(
    "org.json4s" %% "json4s-jackson" % json4sVersion,
    "org.json4s" %% "json4s-ext" % json4sVersion,
    "org.json4s" %% "json4s-native" % json4sVersion
  )


  val testDependencies: Seq[ModuleID] = Seq(
    "org.scalamock" %% "scalamock" % scalamockVersion % "test",
    "org.scalatest" %% "scalatest" % scalatestVersion % "test",
    "org.mockito" %% "mockito-scala" % scalamockitoVersion
  )

  val logbackDependencies = Seq(
    "ch.qos.logback" % "logback-core" % logbackVersion,
    "ch.qos.logback" % "logback-classic" % logbackVersion
  )

}

