import 'dart:html';

class HelpScreen
{
  WindowBase helpWindow;
  
  void showHelpPage(MouseEvent m)
  {
    showHelpScreen("registryMainHelp.html");
  }
  
  void showHelpScreen(String url)
  {  
    if(helpWindow != null && !helpWindow.closed)
      helpWindow.location;
    else
      helpWindow = window.open(url, "",'width=500,height=300,scrollbars=yes');
  }
}