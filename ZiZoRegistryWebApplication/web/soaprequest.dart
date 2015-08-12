library soap;

import 'dart:html';
import 'dart:async';
import 'navigationfunctions.dart';
import 'popupselection.dart';
import 'popupconstruct.dart';
import 'loadscreenelements.dart';

class SoapRequest
{
  String action;
  List<Object> arguments = new List();
  List<String> catalogueNames = new List();
  StringBuffer buffer = new StringBuffer();
  String password;
  HttpRequest request = new HttpRequest();
  String username;
  String _host;

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
          SelectPopup sp = new SelectPopup();
          sp.popupError("details-incorrect", "#popUpDiv");
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
          else if(request.responseText.contains("removeRegistryEntry"))
          {
          }
          else if(request.responseText.contains("addRegistryEntry")){}
          else if(request.responseText.contains("registryEntryExists")){}
        }
        else
        {
          SelectPopup sp = new SelectPopup();
          sp.popupXmlResponse(request.responseText, "#popUpDiv");
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
  
  static List parse(String startTag, String endTag, String text) 
  {
    List<String> projects = new List<String>();
    List projs = text.split(startTag);
      for(int i = 0; i< projs.length; i++) 
      {
         if(projs.elementAt(i) != null && projs.elementAt(i).length > 0 && projs.elementAt(i).contains(endTag)) 
         {
           int index = projs.elementAt(i).indexOf(endTag);
           String project = projs.elementAt(i).substring(0, index);
           projects.add(project);
         }
         else
         {
           projs.remove(i);
         }
      }
      return projects;
   }
  
  static List parseRegistries(String startTag, String endTag, String startTag2, String endTag2, String text)
  {
    List<String> registriesListTrim1 = new List<String>();
    List<String> registriesListTrim2 = new List<String>();
    List<String> registriesFinalList = new List<String>();
    List registries = text.split(startTag);
    for(int i = 0; i < registries.length; i++)
    {
      if(registries.elementAt(i) != null && registries.elementAt(i).length > 0 && registries.elementAt(i).contains(endTag))
      {
        int index = registries.elementAt(i).indexOf(endTag);
        String reg = registries.elementAt(i).substring(0, index);
        registriesListTrim1.add(reg);
      }
      else
      {
        registries.remove(i);
      }
    }
    for(int i2 = 0; i2 < registriesListTrim1.length; i2++)
    {
      List someRegistry = registriesListTrim1[i2].split(startTag2);
      for(int i3 = 0; i3 < someRegistry.length; i3++)
      {
        if(someRegistry[i3].trim() != "")
        {
          registriesListTrim2.add(someRegistry[i3]);
        }
        else
        {
          someRegistry.remove(i3);
        }
      }
    }
    for(int i4 = 0; i4 < registriesListTrim2.length; i4++)
    {
      int index = registriesListTrim2.elementAt(i4).indexOf(endTag2);
      String reg = registriesListTrim2.elementAt(i4).substring(11, index);
      registriesFinalList.add(reg);
    }
    return registriesFinalList;
  }
  
  setProjectList()
  {
    String response = request.responseText;
    List projects = parse("<return>", "</return>", response);
    LoadScreenElements.getProjects(projects);
  }
  
  setRegistryList()
  {
    if(request.responseText.contains("<item>"))
    {
      String response = request.responseText;
      List registryEntries = parseRegistries("<return>", "</return>", "<item>", "</item>", response);
      LoadScreenElements.getRegistryEntries(registryEntries);
    }
    else
    {
      SelectPopup p = new SelectPopup();
      PopupWindow puw = new PopupWindow();
      querySelector("#dismissFinal").onClick.listen(puw.dismissPrompt);
      p.popupError("no-registries", "#popUpDiv");
    }
  }
} 
  