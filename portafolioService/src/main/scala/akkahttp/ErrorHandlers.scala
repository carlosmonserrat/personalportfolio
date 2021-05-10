package akkahttp

import akka.http.scaladsl.model.{HttpResponse, StatusCodes}

object ErrorHandlers {
  def createBadRequestResponse(): HttpResponse = {
    HttpResponse(status = StatusCodes.BadRequest.intValue, entity =
      s"""{
          "status":${StatusCodes.BadRequest.intValue},
          "errorMessage":"${StatusCodes.BadRequest.defaultMessage}"
          }""")
  }

  def createServiceUnavailableError(): HttpResponse = {
    HttpResponse(status = StatusCodes.ServiceUnavailable.intValue, entity =
      s"""{
          "status":${StatusCodes.ServiceUnavailable.intValue},
          "errorMessage":"${StatusCodes.ServiceUnavailable.defaultMessage}"
          }""".stripMargin)
  }

  def createInternalServerError(): HttpResponse = {
    HttpResponse(status = StatusCodes.InternalServerError.intValue, entity =
      s"""{
          "status":${StatusCodes.InternalServerError.intValue},
          "errorMessage":"${StatusCodes.InternalServerError.defaultMessage}"
          }""")
  }
}
