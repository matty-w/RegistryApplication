library functions;

import 'dart:html';
import 'serverrequest.dart';
import 'popupselection.dart';
import 'setelementvalues.dart';
import 'listentobuttons.dart';

class ServerFunctions
{
  void completeDeletion(MouseEvent m)
  {
    List catalogueKeys = SetElementValues.deleteKeys();
    SelectPopup sp = new SelectPopup();
    for(int i = 0; i < catalogueKeys.length; i++)
    {
      ServerRequest.deleteRegistryFile(window.sessionStorage['username'],window.sessionStorage['password']
                                      , catalogueKeys[i], ServerRequest.defaultUri());
    }
    sp.popupSuccess("delete-success", "#popUpDiv");
  }
  
  void deleteButton(MouseEvent m)
  {
    List catalogueKeys = SetElementValues.deleteKeys();
    if(catalogueKeys.length > 0)
    {  
      SelectPopup sp = new SelectPopup();
      sp.popupListFilesForDeletion("list-files", catalogueKeys, "#popUpDiv");
    }
  }
  
  void listenToBox(MouseEvent m)
  {
    TableElement table = querySelector("#registryTable");
    int tableLength = table.rows.length;
    table.hidden = true;
    if(tableLength > 0)
    {
      for(int i = 0; table.rows.length > 0; i++)
      {
        table.deleteRow(0);
      }
    }  
    InputElement selectedProject = querySelector("#projectDropDown");
    window.sessionStorage['project'] = selectedProject.value;
    ServerRequest.getRegistryFiles(window.sessionStorage['username'],window.sessionStorage['password']
                                   ,window.sessionStorage['project'], ServerRequest.defaultUri());
  }
  
  void loadProjects(Event e)
  {
    ServerRequest.listProjects(window.sessionStorage['username'],window.sessionStorage['password']
                                ,ServerRequest.defaultUri());
  }
}