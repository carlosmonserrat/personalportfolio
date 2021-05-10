package akkahttp

import akka.actor.ActorSystem
import akka.http.scaladsl.Http
import akka.http.scaladsl.server.Directives.{Segments, complete, get, parameterMap, path, withRequestTimeout}
import akka.http.scaladsl.server.Route
import logging.Logging
import scaldi.akka.AkkaInjectable
import scaldi.{Injectable, Injector}
import scala.concurrent.ExecutionContextExecutor
import scala.concurrent.duration.{FiniteDuration, MINUTES}
import scala.util.{Failure, Success}

class Routes(implicit injector: Injector) extends Injectable with AkkaInjectable with Logging {

  implicit private val system: ActorSystem =  ActorSystem("portafolioRoutes")
  implicit private val executionContext: ExecutionContextExecutor = system.dispatcher
  private val akkaHttpRequestTimeout: FiniteDuration = FiniteDuration(5, MINUTES)

  def start(host: String, port: Int): Unit = {
    Http().newServerAt(host, port).bind(routes)
      .onComplete {
        case Success(_) =>
          logInfo(s"API endpoint online at http://${host}:${port}/")
        case Failure(e) =>
          logError(s"API endpoint could not start!")
          e.printStackTrace()
          system.terminate()
      }
  }

  private val routes: Route =
    Route.seal(
      withRequestTimeout(akkaHttpRequestTimeout) {
        get {
          parameterMap { parameters =>
            path(Segments) { segments =>
              complete {
                segments match {
                  case List("ping") => "pong"
                  case _ => ErrorHandlers.createBadRequestResponse()
                }
              }
            }
          }
        }
      }
    )
}
