import net.vonbuchholtz.sbt.dependencycheck.DependencyCheckPlugin.autoImport.{dependencyCheckAssemblyAnalyzerEnabled, dependencyCheckFormat, dependencyCheckSuppressionFiles}
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

