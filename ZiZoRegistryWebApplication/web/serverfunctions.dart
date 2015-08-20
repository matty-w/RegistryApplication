library functions;

import 'dart:html';
import 'serverrequest.dart';
import 'popupselection.dart';
import 'setelementvalues.dart';

class ServerFunctions
{
  SelectPopup sp = new SelectPopup();
  
  void completeDeletion(MouseEvent m)
  {
    List catalogueKeys = SetElementValues.deleteKeys();

    for(int i = 0; i < catalogueKeys.length; i++)
    {
      ServerRequest.deleteRegistryFile(window.sessionStorage['username'],window.sessionStorage['password']
                                      , catalogueKeys[i], ServerRequest.defaultUri());
    }
    sp.popup("delete-success", false, false, false, false, true, true, true, false, true, "#popUpDiv");
  }
  
  void completeTask(MouseEvent m)
  {
    InputElement text = querySelector("#addRegistry");
    if(text.innerHtml == "Edit Registry")
    {
      sp.popup("edit-success", false, false, false, false, true, true, true, false, true, "#popUpDiv");
    }
    else if(text.innerHtml == "Add Registry")
    {
      sp.popup("add-success", false, false, false, false, true, true, true, false, true, "#popUpDiv");
    }
  }
  
  void deleteButton(MouseEvent m)
  {
    List catalogueKeys = SetElementValues.deleteKeys();
    if(catalogueKeys.length == 0 || catalogueKeys == null)
    {
      sp.popup("no-entries-selected", false, true, false, false, true, true, true, false, true, "#popUpDiv");
    }
    if(catalogueKeys.length > 0)
    {  
      sp.popupListFilesForDeletion("list-files", catalogueKeys, "#popUpDiv");
    }
  }
  
  void addButton(MouseEvent m)
  {
    sp.popup("add-registry", true, false, true, true, false, true, true, false, false, "#popUpDiv");
  }
  
  void editButton(MouseEvent m)
  {
    sp.popup("edit-registry", true, false, true, false, true, true, true, false, false, "#popUpDiv");
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