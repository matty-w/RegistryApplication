library server;

import 'dart:html';
import 'soaprequest.dart';

class ServerRequest extends SoapRequest
{
  static void login(String username, String password, Function onPass, Function onFail)
  {
    ServerRequest result;
    window.alert(username);
    window.alert(password);
    result = new ServerRequest();
    result.setAction("version");
    result.setUsername(username);
    window.alert("4");
    result.setPassword(password);
    result.getResponse((s) => (s=="true")? onPass() : onFail ());
  }
}