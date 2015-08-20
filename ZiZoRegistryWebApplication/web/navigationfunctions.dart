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
    local['username'] = username.value;
    local['password'] = password.value;
    
    if(username.value == null || username.value.trim() == "")
    {
      sp.popup("no-username", false, true, false, false, true, true, true, false, true, "#popUpDiv");
      return;
    }
    if(password.value == null || password.value.trim() == "")
    {
      sp.popup("no-password", false, true, false, false, true, true, true, false, true, "#popUpDiv");
      return;
    }
    ServerRequest.login(username.value, password.value,ServerRequest.defaultUri(), goToPage, presentErrorPopup);
  }
  
  void logout(MouseEvent m)
  {
    TableElement table = querySelector("#registryTable");
    SelectElement select = querySelector("#projectDropDown");
    int tableLength = table.rows.length;
    select.remove();
    if(tableLength > 0)
    {
      for(int i = 0; table.rows.length > 0; i++)
      {
        table.deleteRow(0);
      }
    }  
    local['username'] = "";
    local['password'] = "";
    local['project'] = "";
    window.location.href = "loginPage.html";
  }
  
  void presentErrorPopup()
  {
    local['username'] = "";
    local['password'] = "";
    sp.popup("details-incorrect", false, true, false, false, true, true, true, false, true, "#popUpDiv");
  }
}