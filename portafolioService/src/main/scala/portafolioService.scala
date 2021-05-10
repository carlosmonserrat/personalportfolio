import akkahttp.Routes
import logging.Logging
import scaldi.akka.AkkaInjectable

object portafolioService extends App with AkkaInjectable with Logging {
  logInfo("Starting DVZA support service API")

  implicit val serviceModules: ServiceModule = new ServiceModule

  private val routes = inject[Routes]
  private val port = 8081

  routes.start("0.0.0.0", port)
}

