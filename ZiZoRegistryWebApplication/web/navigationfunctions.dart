library navigation;

import 'dart:html';
import 'popupselection.dart';
import 'serverrequest.dart';

class NavigationFunctions
{
  StringBuffer buffer = new StringBuffer();
  Storage local = window.sessionStorage;
  HttpRequest request;
  SelectPopup sp = new SelectPopup();
 
  void goToHomePage(MouseEvent m)
  {
    window.location.href = "registryMain.html";
  }
  
  void goToPage()
  {
    window.location.href = "registryMain.html";
  }
    
  void login(MouseEvent m)
  {
    InputElement username = querySelector("#usernameTextbox");
    InputElement password = querySelector("#passwordTextbox");
    InputElement project =  querySelector("#projectTextbox");
    local['username'] = username.value;
    local['password'] = password.value;
    local['project'] = project.value;
    
    if(username.value == null || username.value.trim() == "")
    {
      sp.popupError("no-username", "#popUpDiv");
      return;
    }
    if(password.value == null || password.value.trim() == "")
    {
      sp.popupError("no-password", "#popUpDiv");
      return;
    }
    ServerRequest.login(username.value, password.value, goToPage, presentErrorPopup);
  }
  
  void logout(MouseEvent m)
  {
    Storage local = window.sessionStorage;
    local['username'] = "";
    local['password'] = "";
    local['project'] = "";
    window.location.href = "loginPage.html";
  }
  
  void presentErrorPopup()
  {
    local['username'] = "";
    local['password'] = "";
    sp.popupError("details-incorrect", "#popUpDiv");
  } 
}