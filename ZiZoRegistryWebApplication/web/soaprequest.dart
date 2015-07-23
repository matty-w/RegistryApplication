library soap;

import 'dart:html';
import 'dart:async';

class SoapRequest
{
  StringBuffer buffer = new StringBuffer();
  List<Object> arguments = new List();
  String username;
  String password;
  String action;
  HttpRequest request = new HttpRequest();
  
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
  
  void setXml()
  {
    writeXmlHeader();
    writeXmlBody();
    writeXmlFooter();
  }
  
  void getResponse(Function onReturn)
  {
    sendRequest().listen((ProgressEvent e)
    {
      window.alert(request.readyState.toString()+" "+request.status.toString());
      if(request.readyState == 4 && request.status == 200)
      {
        onReturn(window.alert("Some Response"));
      }  
    });
  }
  
  void writeXmlHeader()
  {
    buffer.writeln("<?xml version='1.0' encoding='UTF-8'?>");
    buffer.writeln("<S:Envelope xmlns:S='http://schemas.xmlsoap.org/soap/envelope/'>");
    buffer.writeln("<S:Header/>");
    buffer.writeln("<S:Body>");
  }

  void writeXmlBody()
  {
    window.alert("Action: "+getAction());
    buffer.writeln("<ns2:"+getAction()+" xmlns:ns2='http://service.viperdb.decsim.com/'>");
    writeRequestArguments();
    buffer.writeln("</ns2:"+getAction()+">");
  }
  
  void writeRequestArguments()
  {
    for(int i = 0; i < numberOfArguments(); i++)
    {
      writeRequestArgument(i);
    }
  }
  
  void writeRequestArgument(int i)
  {
    buffer.writeln("<args"+i.toString()+">"+getArgument(i)+"</arg"+i.toString()+">");
    window.alert("<args"+i.toString()+">"+getArgument(i)+"</arg"+i.toString()+">");
  }
  
  int numberOfArguments()
  {
    return arguments.length;
  }
  
  String getArgument(int i)
  {
    return arguments[i];
  }

  void writeXmlFooter()
  {
    buffer.writeln("</S:Body>");
    buffer.writeln("</S:Envelope>");
  }
  
  String uri()
  {
    return window.location.protocol+"//"+window.location.host+"/DatabaseService/j_security_check";
  }
  
  void setAction(String a)
  {
    action = a;
  }
  
  String getAction()
  {
    return action;
  }
  
  void addArgument(String arg)
  {
    arguments.add(arg);
  }
  
  String jUsername()
  {
    return "j_username="+username;
  }
  
  void setUsername(String u)
  {
    username = u;
  }
  
  String jPassword()
  {
    return "j_password="+password;
  }
  
  void setPassword(String p)
  {
    password = p;
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
  
  void setHeaders()
  {
     window.alert("Basic "+encodeCredentials());
     request.setRequestHeader("accept", "text/html, image/gif, image/jpeg, *; q=.2, */*; q=.2");
     request.setRequestHeader('Content-Type', 'text/xml');
     request.setRequestHeader("Authorization", "Basic "+encodeCredentials());
     request.setRequestHeader("soapaction", "http://service.viperdb.decsim.com/DatabaseService/count");
  }
}  
  