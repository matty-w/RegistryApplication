library server;

import 'soaprequest.dart';
import 'dart:html';

class ServerRequest extends SoapRequest
{
  static void login(String username, String password, String host, Function onPass, Function onFail)
  {
    ServerRequest result;
    result = new ServerRequest();
    result.setAction("test");
    result.addArgument("version");
    result.setUsername(username);
    result.setPassword(password);
    result.setHost(host);
    result.getLoginResponse();
  }
  
  static void listProjects(String username, String password, String host)
  {
    ServerRequest result;
    result = new ServerRequest();
    result.setHost(host);
    result.setAction("listProjects");
    result.getResponse();
  }
  
  static void getRegistryFiles(String username, String password, String project, String host)
  {
    ServerRequest result;
    result = new ServerRequest();
    result.setHost(host);
    result.setAction("listRegistryEntriesFor");
    result.addArgument(project);
    result.getResponse();
  }
  
  
  static void deleteRegistryFile(String username, String password, String file, String host)
  {
    ServerRequest result;
    result = new ServerRequest();
    result.setHost(host);
    result.setAction("removeRegistryEntry");
    result.addArgument(file);
    result.getResponse(); 
  }
  
  static void addRegistryFile()
  {
    
  }
  
  @override
  namespace()
  {
    return "service.zizodb.decsim.com";
  }
  
  String path()
  {
    return "DatabaseService/DatabaseService";
  }
  
  static String defaultUri()
  {
    return window.location.host;
  }
}