library buttons;

import 'dart:html';
import 'navigationfunctions.dart';
import 'helpscreen.dart';
import 'showfolders.dart';
import 'popupconstruct.dart';
import 'serverfunctions.dart';

class ListenToButtons
{
  NavigationFunctions navigate = new NavigationFunctions();
  PopupWindow p = new PopupWindow();
  
  void listenToLoginButtons()
  {
    querySelector("#submitButton").onClick.listen(navigate.login);
    querySelector("#dismissFinal").onClick.listen(p.dismissPrompt);
  }
  
  void listenToRegistryButtons()
  {
    HelpScreen h = new HelpScreen();
    ShowFolders f = new ShowFolders();
    ServerFunctions sf = new ServerFunctions();
    window.onLoad.listen(sf.loadPreviousTable);
    window.addEventListener('storage', sf.showStorage);
    querySelector("#homePageButton").onClick.listen(navigate.reloadPage);
    querySelector("#helpPageButton").onClick.listen(h.showHelpPage);
    querySelector("#logoutButton").onClick.listen(navigate.logout);
    querySelector("#usernameOutput").innerHtml = window.sessionStorage['username'];
    querySelector("#projectDropDown").onChange.listen(sf.listenToBox);
    querySelector("#deleteButton").onClick.listen(sf.deleteButton);
    querySelector("#editButton").onClick.listen(sf.editButton);
    querySelector("#addButton").onClick.listen(sf.addButton);
    querySelector("#no").onClick.listen(p.dismissPrompt);
    querySelector("#yes").onClick.listen(sf.completeDeletion);
    querySelector("#dismissFinal").onClick.listen(p.dismissPromptReload);
    querySelector("#addRegistry").onClick.listen(sf.completeTask);
    querySelector("#browseButton").onClick.listen(f.showFoldersPage);
  }
  
  void listenToFolderExplorer()
  {
    ShowFolders f = new ShowFolders();
    ServerFunctions sf = new ServerFunctions();
    querySelector("#cancelExplorer").onClick.listen(f.dismissExplorer);
    querySelector("#okExplorer").onClick.listen(sf.setItem);
  
  }
}