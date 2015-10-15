library folders;

import 'dart:html';
import 'serverfunctions.dart';

class ShowFolders
{
  WindowBase helpWindow;
  
  void showFoldersPage(MouseEvent m)
  {
    showFoldersScreen("folderExplorer.html");
  }
  
  void showFoldersScreen(String url)
  {  
    if(helpWindow != null && !helpWindow.closed)
      helpWindow.location;
    else
      helpWindow = window.open(url, "",'width=1036,height=567,scrollbars=yes,resize=none');
  }
  
  void dismissExplorer(MouseEvent m)
  {
    window.close();
  }
}