library soap;

import 'dart:html';
import 'dart:async';

class SoapRequest
{
  String action;
  List<Object> arguments = new List();
  StringBuffer buffer = new StringBuffer();
  String password;
  HttpRequest request = new HttpRequest();
  String username;

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
  
  void getResponse(Function onReturn)
  {
    sendRequest().listen((ProgressEvent e)
    {
      window.alert(request.readyState.toString()+" "+request.status.toString());
      if(request.readyState == 4)
      {
        if(request.status == 200)
        {
          onReturn(window.alert("Some Response"));
        }
        if(request.status == 404)
        {
          onReturn(window.alert("404 - Page Was Not Found."));
        }
        if(request.status == 401)
        {
          onReturn(window.alert("401 - Credentials Incorrect"));
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
  
  Stream<ProgressEvent> sendRequest()
  {
    String uriv = uri();
    request.open("POST", uriv);
    setHeaders();
    setXml();
    request.send(buffer.toString());
    window.alert(buffer.toString());
    return request.onReadyStateChange;
  }
  
  void setAction(String a)
  {
    action = a;
  }
  
  void setHeaders()
  {
     window.alert("Basic "+encodeCredentials());
     request.setRequestHeader("accept", "text/html, image/gif, image/jpeg, *; q=.2, */*; q=.2");
     request.setRequestHeader('Content-Type', 'text/xml');
     request.setRequestHeader("Authorization", "Basic "+encodeCredentials());
     request.setRequestHeader("soapaction", "http://service.viperdb.decsim.com/DatabaseService/count");
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
  
  String uri()
  {
    return window.location.protocol+"//"+window.location.host+"/DatabaseService/j_security_check";
  }
  
  void writeRequestArgument(int i)
  {
    buffer.writeln("<args"+i.toString()+">"+getArgument(i)+"</arg"+i.toString()+">");
    window.alert("<args"+i.toString()+">"+getArgument(i)+"</arg"+i.toString()+">");
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
    window.alert("Action: "+getAction());
    buffer.writeln("<ns2:"+getAction()+" xmlns:ns2='http://service.viperdb.decsim.com/'>");
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
} 
  