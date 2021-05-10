import akkahttp.Routes
import scaldi.Module

class ServiceModule extends Module{

  bind[Routes] to injected[Routes]

}
