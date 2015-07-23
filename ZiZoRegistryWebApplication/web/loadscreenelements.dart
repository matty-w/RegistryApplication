library elements;

import 'dart:html';
import 'navigationfunctions.dart';
import 'changetable.dart';
import 'helpscreen.dart';
import 'popupconstruct.dart';

class LoadScreenElements
{
  void loginPage()
  {
    PopupWindow p = new PopupWindow();
    NavigationFunctions navigate = new NavigationFunctions();
    querySelector("#submitButton").onClick.listen(navigate.login);
    querySelector("#dismissFinal").onClick.listen(p.dismissPrompt);
  }
  
  void registryMain()
  {
    NavigationFunctions navigate = new NavigationFunctions();
    ChangeTable table = new ChangeTable();
    HelpScreen h = new HelpScreen();
    querySelector("#homePage").onClick.listen(navigate.goToHomePage);
    querySelector("#helpButton").onClick.listen(h.showHelpPage);
    querySelector("#logOut").onClick.listen(navigate.logout);
    querySelector("#usernameOutput").innerHtml = window.sessionStorage['username'];
    InputElement project = querySelector("#projectDropDown");
    project.value = window.sessionStorage['project'];
    table.setTable();
    querySelector("#searchButton").onClick.listen(listenToBox);
  }
  
  void listenToBox(MouseEvent m)
  {
    ChangeTable table = new ChangeTable();
    InputElement project = querySelector("#projectDropDown");
    window.sessionStorage['project'] = project.value;
    table.setTable();
  }
}