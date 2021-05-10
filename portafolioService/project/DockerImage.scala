import java.time.LocalDateTime
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
      "maintainer" -> "Carlos Rojas",
      "description" -> "this is the backend for the personal portafolio"
    )
  )

  private def timestamp: String =
    DateTimeFormatter.ofPattern("yyyyMMdd.HHmmss").format(LocalDateTime.now())
}
