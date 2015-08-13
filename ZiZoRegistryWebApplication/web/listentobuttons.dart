library buttons;

import 'dart:html';
import 'navigationfunctions.dart';
import 'helpscreen.dart';
import 'popupconstruct.dart';
import 'serverrequest.dart';
import 'popupselection.dart';
import 'setelementvalues.dart';
import 'loadscreenelements.dart';
import 'serverfunctions.dart';

class ListenToButtons
{
  void listenToLoginButtons()
  {
    PopupWindow p = new PopupWindow();
    NavigationFunctions navigate = new NavigationFunctions();
    querySelector("#submitButton").onClick.listen(navigate.login);
    querySelector("#dismissFinal").onClick.listen(p.dismissPrompt);
  }
  
  void listenToRegistryButtons()
  {
    PopupWindow p = new PopupWindow();
    NavigationFunctions navigate = new NavigationFunctions();
    HelpScreen h = new HelpScreen();
    ServerFunctions sf = new ServerFunctions();
    querySelector("#homePageButton").onClick.listen(navigate.goToHomePage);
    querySelector("#helpPageButton").onClick.listen(h.showHelpPage);
    querySelector("#logoutButton").onClick.listen(navigate.logout);
    querySelector("#usernameOutput").innerHtml = window.sessionStorage['username'];
    querySelector("#searchButton").onClick.listen(sf.listenToBox);
    querySelector("#deleteButton").onClick.listen(sf.deleteButton);
    querySelector("#no").onClick.listen(p.dismissPrompt);
    querySelector("#yes").onClick.listen(sf.completeDeletion);
    querySelector("#dismissFinal").onClick.listen(p.dismissPrompt);
  }
}