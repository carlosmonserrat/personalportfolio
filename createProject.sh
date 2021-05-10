#!/bin/sh

SBTVERSION=1.4.7

# shellcheck disable=SC2162
echo "Creating a project"
echo "Please give a name to the project:"
read ProjectName
# shellcheck disable=SC2039
mkdir -p "$ProjectName"/src/{main,test}/{resources,scala}
mkdir "$ProjectName"/lib "$ProjectName"/project "$ProjectName"/target


function createDependencyManager(){
   echo 'import sbt._

object Dependencies {
  lazy val allDependencies: Seq[ModuleID] =
    akkaDependencies ++
      routeDependencies ++
      json4sDependencies ++
      slickDependencies ++
      dbDependencies ++
      testDependencies ++
      logbackDependencies ++
      kafkaDependencies 

  private lazy val akkaHttpVersion = "10.1.8"
  private lazy val akkaVersion = "2.5.20"
  private lazy val scaldiVersion = "0.5.8"
  private lazy val akkaHttpCorsVersion = "0.4.1"
  private lazy val json4sVersion = "3.6.7"
  private lazy val slickVersion: String = "3.2.1"
  private lazy val postgresVersion: String = "42.2.13"
  private lazy val scalamockVersion: String = "4.1.0"
  private lazy val scalatestVersion: String = "3.0.5"
  private lazy val scalamockitoVersion = "1.15.0"
  private lazy val logbackVersion: String = "1.2.3"
  private lazy val kafkaVersion = "2.6.0"
  private lazy val hapiVersion = "5.1.0"

  val akkaDependencies = Seq(
    "com.typesafe.akka" %% "akka-http" % akkaHttpVersion,
    "com.typesafe.akka" %% "akka-http-spray-json" % akkaHttpVersion,
    "com.typesafe.akka" %% "akka-stream" % akkaVersion,
    "com.typesafe.akka" %% "akka-testkit" % akkaVersion % Test,
    "com.typesafe.akka" %% "akka-stream-testkit" % akkaVersion % Test,
    "com.typesafe.akka" %% "akka-http-testkit" % akkaHttpVersion % Test,
    "org.scaldi" %% "scaldi-akka" % scaldiVersion
  )

  val routeDependencies = Seq(
    "ch.megard" %% "akka-http-cors" % akkaHttpCorsVersion
  )

  val json4sDependencies: Seq[ModuleID] = Seq(
    "org.json4s" %% "json4s-jackson" % json4sVersion,
    "org.json4s" %% "json4s-ext" % json4sVersion,
    "org.json4s" %% "json4s-native" % json4sVersion,
    "ca.uhn.hapi.fhir" % "hapi-fhir-base" % hapiVersion,
    "ca.uhn.hapi.fhir" % "hapi-fhir-structures-dstu3" % hapiVersion
  )

  val slickDependencies: Seq[ModuleID] = Seq(
    "com.typesafe.slick" %% "slick" % slickVersion,
    "com.typesafe.slick" %% "slick-hikaricp" % slickVersion
  )

  val dbDependencies: Seq[ModuleID] = Seq(
    "org.postgresql" % "postgresql" % postgresVersion
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

  val kafkaDependencies: Seq[ModuleID] = Seq(
    "org.apache.kafka" %% "kafka" % kafkaVersion
  )

}
'> "$ProjectName"/project/Dependencies.scala
}


function createDockerImageConfig(){

  echo "Mantainer Name: "
  read MantainerName

  echo "Add some Descripotion: "
  read ProjectDescription

  echo 'import java.time.LocalDateTime
import java.time.format.DateTimeFormatter

import com.typesafe.sbt.packager.docker.DockerPlugin.autoImport._
import com.typesafe.sbt.packager.linux.LinuxPlugin.autoImport.defaultLinuxInstallLocation
import sbt.Keys.{isSnapshot, name, version}

object DockerImage {

  lazy val publishToRegistry = Seq(
    dockerBaseImage := "registry.portavita.net/a-team/jre1.8:1.8.0_181-latest",
    defaultLinuxInstallLocation in Docker := "/opt/" + name.value,
    dockerUpdateLatest := true,
    dockerRepository := Some("registry.portavita.net"),
    dockerUsername := Some("sogimasol"),
    version in Docker := {
      if (isSnapshot.value) s"${version.value}-$timestamp" else version.value
    },
    dockerLabels := Map(
      "maintainer" -> "'$MantainerName'",
      "description" -> "'$ProjectDescription'"
    )
  )

  private def timestamp: String =
    DateTimeFormatter.ofPattern("yyyyMMdd'.'HHmmss").format(LocalDateTime.now())
}'> "$ProjectName"/project/DockerImage.scala
}

function DependencyCheck(){
  echo 'import net.vonbuchholtz.sbt.dependencycheck.DependencyCheckPlugin.autoImport.{dependencyCheckAssemblyAnalyzerEnabled, dependencyCheckFormat, dependencyCheckSuppressionFiles}
import sbt.Keys.baseDirectory
import sbt._

object DependencyCheck {

  lazy val settings = Seq(
    dependencyCheckFormat := "ALL",
    dependencyCheckSuppressionFiles := (dependencyCheckSuppressionFiles in ThisBuild).value,
    dependencyCheckAssemblyAnalyzerEnabled := Some(false),
    dependencyCheckSuppressionFiles in ThisBuild := Seq(baseDirectory.value / "suppressions.xml")
  )
}
'> "$ProjectName"/project/DependencyCheck.scala
}


function createBuild(){
    echo 'lazy val root = Project(id = "'$ProjectName'", base = file("."))
  .enablePlugins(JavaServerAppPackaging)
  .settings(
    organization := "eu.portavita",
    scalaVersion := "2.12.12",
    libraryDependencies ++= Dependencies.allDependencies
  )
  .settings(DockerImage.publishToRegistry)
  .settings(DependencyCheck.settings)
' > "$ProjectName"/build.sbt
}


function createPlugins(){
  echo 'addSbtPlugin("io.spray" % "sbt-revolver" % "0.9.1")
addSbtPlugin("com.typesafe.sbt" % "sbt-native-packager" % "1.3.19")
addSbtPlugin("net.vonbuchholtz" % "sbt-dependency-check" % "2.0.0")
addSbtPlugin("net.virtual-void" % "sbt-dependency-graph" % "0.10.0-RC1")' > "$ProjectName"/project/Plugins.sbt
}

function createSbtVersionConfig(){
  echo 'sbt.version='$SBTVERSION > "$ProjectName"/project/build.properties
}

function createMainObject(){
echo "Give a name to the main object (use camel case to avoid errors):"
read mainObjectname

echo 'object '"$mainObjectname"' extends App {
  println("Hola mundo")
}' > "$ProjectName"/src/main/scala/"$mainObjectname".scala
}


function createStartScript(){
  echo '#!/bin/sh
sbt ~reStart' > "$ProjectName"/start.sh
}

function createReadMe(){
  echo '
This was developed by Valravnx
' > "$ProjectName"/README.md

}

function sbtIndexing(){
  cd "$ProjectName"
  sbt compile
}
 

createDependencyManager
createDockerImageConfig
DependencyCheck

createBuild
createPlugins
createMainObject
createStartScript
createReadMe
createSbtVersionConfig
sbtIndexing

