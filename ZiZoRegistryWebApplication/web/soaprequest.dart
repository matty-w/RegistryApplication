library soap;

import 'dart:html';
import 'dart:async';
import 'navigationfunctions.dart';
import 'popupselection.dart';
import 'popupconstruct.dart';
import 'parseresponse.dart';
import 'setelementvalues.dart';

class SoapRequest
{
  String action;
  List<Object> arguments = new List();
  List<String> catalogueNames = new List();
  List<String> projectNames = new List();
  Storage local = window.sessionStorage;
  StringBuffer buffer = new StringBuffer();
  String password;
  HttpRequest request = new HttpRequest();
  String username;
  String _host;
  SelectPopup sp = new SelectPopup();

  void addArgument(String arg)
  {
    arguments.add(arg);
  }
  
  String createCredentials()
  {
    return username+":"+password;
  }
  
  String encodeCredentials()
  {
    String credentials = createCredentials();
    var base64 = window.btoa(credentials);
    window.sessionStorage['credentials'] = base64.toString();
    return base64.toString();
  }
  
  String getAction()
  {
    return action;
  }
  
  String getArgument(int i)
  {
    return arguments[i];
  }
  
  void getLoginResponse()
  {
    sendLoginRequest().listen((ProgressEvent e)
    {
      if(request.readyState == 4)
      {
        if(request.status == 200)
        {
          NavigationFunctions nav = new NavigationFunctions();
          nav.goToPage();
        }
        else
        {
          sp.popup("details-incorrect", null, null, false, true, false, false, true, true, true, false, 
                    true, "#popUpDiv");
        }
      }  
    });
  }
  
  void getPortfolioResponse()
  {
    sendPortfolioRequest().listen((ProgressEvent e)
    {
      if(request.readyState == 4)
      {
        if(request.status == 200)
        {
          setFoldersList();
        }
        else if(request.status == 500)
        {
          setEmptyList();
        }
      }
    });
  }
  
  void getPortfolioFileResponse()
  {
    sendPortfolioRequest().listen((ProgressEvent e)
    {
      if(request.readyState == 4)
      {
        if(request.status == 200)
        {
          setFileList();
        }
        else if(request.status == 500)
        {
          window.alert("no registries");
        }
      }
    });
  }
  
  void getResponse()
  {
    sendRequest().listen((ProgressEvent e)
    {
      if(request.readyState == 4)
      {
        if(request.status == 200)
        {
          if(request.responseText.contains("listProjects"))
          {  
            setProjectList();
          }  
          else if(request.responseText.contains("listRegistryEntriesFor"))
          {
            setRegistryList();
          } 
          else if(request.responseText.contains("getPropertiesList"))
          {
            setFoldersList();
          }
          else if(request.responseText.contains("removeRegistryEntry"))
          {
          }
          else if(request.responseText.contains("addRegistryEntry")){}
          else if(request.responseText.contains("registryEntryExists")){}
        }
        else
        {
          SelectPopup sp = new SelectPopup();
          sp.popup(request.responseText, null, null, false, true, false, false, true, true, 
                    true, false, true, "#popUpDiv");
        }
      }
    });
  }
  
  String jPassword()
  {
    return "j_password="+password;
  }
  
  String jUsername()
  {
    return "j_username="+username;
  }
  
  int numberOfArguments()
  {
    return arguments.length;
  }
  
  Stream<ProgressEvent> sendLoginRequest()
  {
    String uriv = uri();
    request.open("POST", uriv);
    setHeaders();
    setXml();
    request.send(buffer.toString());
    return request.onReadyStateChange;
  }
  
  Stream<ProgressEvent> sendRequest()
  {
    String uriv = uri();
    request.open("POST", uriv);
    request.setRequestHeader("accept", "text/html, image/gif, image/jpeg, *; q=.2, */*; q=.2");
    request.setRequestHeader('Content-Type', 'text/xml');
    request.setRequestHeader("Authorization", "Basic "+window.sessionStorage['credentials']);
    setXml();
    request.send(buffer.toString());
    return request.onReadyStateChange;
  }
  
  Stream<ProgressEvent> sendPortfolioRequest()
  {
    String uriv = "http://"+host()+"/PortfolioService/PortfolioServiceService";
    request.open("POST", uriv);
    request.setRequestHeader("accept", "text/html, image/gif, image/jpeg, *; q=.2, */*; q=.2");
    request.setRequestHeader('Content-Type', 'text/xml');
    request.setRequestHeader("Authorization", "Basic "+window.sessionStorage['credentials']);
    buffer.writeln("<?xml version='1.0' encoding='UTF-8'?>");
    buffer.writeln("<S:Envelope xmlns:S='http://schemas.xmlsoap.org/soap/envelope/'>");
    buffer.writeln("<S:Header/>");
    buffer.writeln("<S:Body>");
    buffer.writeln("<ns2:"+getAction()+" xmlns:ns2='http://"+"server.decsim.com"+"/'>");
    writeRequestArguments();
    buffer.writeln("</ns2:"+getAction()+">");
    buffer.writeln("</S:Body>");
    buffer.writeln("</S:Envelope>");
    request.send(buffer.toString());
    return request.onReadyStateChange;
  }
  
  void setAction(String a)
  {
    action = a;
  }
  
  void setHeaders()
  {
    request.setRequestHeader("accept", "text/html, image/gif, image/jpeg, *; q=.2, */*; q=.2");
    request.setRequestHeader('Content-Type', 'text/xml');
    request.setRequestHeader("Authorization", "Basic "+encodeCredentials());
    request.setRequestHeader("soapaction", "http://"+namespace()+"/"+path());
  }
  
  void setPassword(String p)
  {
    password = p;
  }
  
  void setUsername(String u)
  {
    username = u;
  }
  
  void setXml()
  {
    writeXmlHeader();
    writeXmlBody();
    writeXmlFooter();
  }
  
  void writeRequestArgument(int i)
  {
    buffer.writeln("<arg"+i.toString()+">"+getArgument(i)+"</arg"+i.toString()+">");
  }
  
  void writeRequestArguments()
  {
    for(int i = 0; i < numberOfArguments(); i++)
    {
      writeRequestArgument(i);
    }
  }
  
  void writeXmlBody()
  {
    buffer.writeln("<ns2:"+getAction()+" xmlns:ns2='http://"+namespace()+"/'>");
    writeRequestArguments();
    buffer.writeln("</ns2:"+getAction()+">");
  }
  
  void writeXmlFooter()
  {
    buffer.writeln("</S:Body>");
    buffer.writeln("</S:Envelope>");
  }
  
  void writeXmlHeader()
  {
    buffer.writeln("<?xml version='1.0' encoding='UTF-8'?>");
    buffer.writeln("<S:Envelope xmlns:S='http://schemas.xmlsoap.org/soap/envelope/'>");
    buffer.writeln("<S:Header/>");
    buffer.writeln("<S:Body>");
  }
  
  String xmlResponseText()
  {
    Node envelope;
    Node body;
    Node response;
    
    envelope = request.responseXml.nodes[0];
    body = envelope.nodes[0];
    response = body.nodes[0];
    return response.text;
  }
  
  String namespace()
  {
    return "";
  }
  
  String packageName()
  {
    return host()+"/"+path();
  }
  
  String host()
  {
    return _host;
  }
  
  String path()
  {
    return "";
  }
  
  String uri()
  {
    return "http://"+packageName();
  }
  
  setHost(String h)
  {
    _host = h;
  }
    
  setProjectList()
  {
    String response = request.responseText;
    List projects = ParseResponse.parse("<return>", "</return>", response);
    for(int i = 0; i < projects.length; i++)
    {
      local['project$i'] = projects[i];
    }
    SetElementValues.getProjects(projects);
  }
  
  setRegistryList()
  {
    if(request.responseText.contains("<item>"))
    {
      String response = request.responseText;
      List registryEntries = ParseResponse.parseRegistries("<return>", "</return>", "<item>", "</item>", response);
      SetElementValues.getRegistryEntries(registryEntries);
    }
    else
    {
      PopupWindow puw = new PopupWindow();
      querySelector("#dismissFinal").onClick.listen(puw.dismissPrompt);
      sp.popup("no-registries", null, null, false, true, false, false, true, false, true, true, true, "#popUpDiv");
    }
  }
  
  setFoldersList()
  {
    List projectFolders = new List<String>();
    String response = request.responseText;
    projectFolders = ParseResponse.parseFolderNames("<return>", "</return>", "<item>", "</item>", response);
    int folderLength = projectFolders.length;
    SetElementValues.setProjectFoldersList(folderLength);
  }
  
  setFileList()
  {
    List projectFiles = new List<String>();
    String response = request.responseText;
    projectFiles = ParseResponse.parseFileNames("<return>", "</return>", "<item>", "</item>", response);
    int fileLength =  projectFiles.length;
    SetElementValues.setProjectFilesList(fileLength);
  }
  
  setEmptyList()
  {
    TableElement table = querySelector("#projectFolders");
    table.innerHtml = "";
  }
} 
  