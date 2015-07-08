library navigation;

import 'dart:html';
import 'popupselection.dart';

class NavigationFunctions
{
  login(MouseEvent m)
  {
    SelectPopup sp = new SelectPopup();
    InputElement username = querySelector("#usernameTextbox");
    InputElement password = querySelector("#passwordTextbox");
    InputElement project =  querySelector("#projectTextbox");
    Storage local = window.sessionStorage;
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
    else
    {
      window.location.href = "registryMain.html";
    }
  }
  
  logout(MouseEvent m)
  {
    Storage local = window.sessionStorage;
    local['username'] = "";
    local['password'] = "";
    local['project'] = "";
    window.location.href = "loginPage.html";
  }
  
  goToHomePage(MouseEvent m)
  {
    window.location.href = "registryMain.html";
  }

}