library elements;

import 'dart:html';
import 'serverfunctions.dart';
import 'listentobuttons.dart';

class LoadScreenElements
{
  void loginPage()
  {
    ListenToButtons ltb = new ListenToButtons();
    ltb.listenToLoginButtons();
  }
  
  void registryMain()
  {
    ServerFunctions sf = new ServerFunctions();
    ListenToButtons ltb = new ListenToButtons();
    window.onLoad.listen(sf.loadProjects);
    ltb.listenToRegistryButtons();
  }
}