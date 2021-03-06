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
  
  static void addRegistryFile(String username, String password, String key, String path, String host)
  {
    ServerRequest result;
    result = new ServerRequest();
    result.setHost(host);
    result.setAction("addRegistryEntry");
    result.addArgument(key);
    result.addArgument(path);
    result.getResponse();
  }
  
  static void  editRegistryFile(String username, String password, String key, String path, String host)
  {
    ServerRequest result;
    result = new ServerRequest();
    result.setHost(host);
    result.setAction("editRegistryFile");
    result.addArgument(key);
    result.addArgument(path);
    result.getResponse();
  }
  
  static void showProjectFolders(String username, String password, String projectName, String key, String host)
  {
    ServerRequest result;
    result = new ServerRequest();
    result.setHost(host);
    result.setAction("getPropertiesList");
    result.addArgument(projectName);
    result.addArgument(key);
    result.getPortfolioResponse();   
  }
  
  static void showProjectFiles(String username, String password, String projectPath, String key, String host)
  {
    ServerRequest result;
    result = new ServerRequest();
    result.setHost(host);
    result.setAction("getPropertiesList");
    result.addArgument(projectPath);
    result.addArgument(key);
    result.getPortfolioFileResponse();
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