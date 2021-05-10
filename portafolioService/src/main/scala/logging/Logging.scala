package logging

import org.slf4j.LoggerFactory

trait Logging {
  private val logger = LoggerFactory.getLogger(this.getClass)

  def logInfo(message: String): Unit = logger.info(message)

  def logWarning(message: String): Unit = logger.warn(message)

  def logError(message: String): Unit = logger.error(message)

  def logDebug(message: String): Unit = logger.debug(message)
}
