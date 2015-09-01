library elements;

import 'dart:html';
import 'serverfunctions.dart';
import 'listentobuttons.dart';

class LoadScreenElements
{
  ListenToButtons ltb = new ListenToButtons();
  
  void loginPage()
  {
    ltb.listenToLoginButtons();
  }
  
  void registryMain()
  {
    ServerFunctions sf = new ServerFunctions();
    window.onLoad.listen(sf.loadProjects);
    ltb.listenToRegistryButtons();
  }
}
