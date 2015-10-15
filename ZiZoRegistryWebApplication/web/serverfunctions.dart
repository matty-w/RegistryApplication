library functions;

import 'dart:html';
import 'serverrequest.dart';
import 'popupselection.dart';
import 'setelementvalues.dart';

List<String> projectList = new List();

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
    sp.popup("delete-success", null, null, false, false, false, false, true, true, true, false, true, "#popUpDiv");
  }
  
  void completeTask(MouseEvent m)
  {
    InputElement text = querySelector("#addRegistry");
    if(text.innerHtml == "Edit Registry")
    {
      sp.popup("edit-success", null, null, false, false, false, false, true, true, true, false, true, "#popUpDiv");
    }
    else if(text.innerHtml == "Add Registry")
    {
      sp.popup("add-success", null, null, false, false, false, false, true, true, true, false, true, "#popUpDiv");
    }
  }
  
  void deleteButton(MouseEvent m)
  {
    List catalogueKeys = SetElementValues.deleteKeys();
    if(catalogueKeys.length == 0 || catalogueKeys == null)
    {
      sp.popup("no-entries-selected", null, null, false, true, false, false, true, false, true, true, true, "#popUpDiv");
    }
    if(catalogueKeys.length > 0)
    {  
      sp.popup("list-files", null, catalogueKeys, false, true, false, false, true, false, false, true, true, "#popUpDiv");
    }
  }
  
  void addButton(MouseEvent m)
  {
    sp.popup("add-registry", null, null, true, false, true, true, false, true, true, false, false, "#popUpDiv");
  }
  
  void editButton(MouseEvent m)
  {
    List catalogueKeys = SetElementValues.deleteKeys();
    if((catalogueKeys.length == 0 || catalogueKeys == null))
    {
      sp.popup("no-entries-selected-edit", null, null, false, true, false, false, true, false, true, true, 
          true, "#popUpDiv");
    }
    if(catalogueKeys.length > 1)
    {
      sp.popup("too-many-selected", null, null, false, true, false, false, true, true, true, false, true, "#popUpDiv"); 
    }
    else if(catalogueKeys.length == 1)
    {
      String a = catalogueKeys[0];
      sp.popup("edit-registry", a, null, true, false, true, false, true, true, true, false, false, "#popUpDiv");
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
    window.localStorage['project'] = window.sessionStorage['project'];
    ServerRequest.getRegistryFiles(window.sessionStorage['username'],window.sessionStorage['password']
                                   ,window.sessionStorage['project'], ServerRequest.defaultUri());
  }
  
  void loadPreviousTable(Event e)
  {
    setProject();
    ServerRequest.getRegistryFiles(window.sessionStorage['username'], window.sessionStorage['password']
                                  , window.localStorage['project'], ServerRequest.defaultUri());
  }
  
  void setProject()
  {
    SelectElement dropDown = querySelector("#projectDropDown");
    for(int i = 0; i < dropDown.length; i++)
    {
      if(dropDown.options[i].text == window.localStorage['project'])
      {
        dropDown.options[i].selected = true;
      }
    }
  }
  
  static void storeProjects(List projects)
  {
    projectList = projects;
  }
  
  void loadProjects(Event e)
  {
    ServerRequest.listProjects(window.sessionStorage['username'],window.sessionStorage['password']
                                    ,ServerRequest.defaultUri());
  }
  
  void loadExplorerProjects(Event e)
  {
    int i = int.parse(window.sessionStorage['projectsLength']);
    SetElementValues.setProjectExplorerList(i);
  }
  
  void showFolders(int i)
  {
    TableElement table = querySelector("#projectFolders");
    OutputElement title = querySelector("#projectSelected");
    InputElement folderPathBox = querySelector("#folderPath");
    ButtonElement ok = querySelector("#okExplorer");
    ok.disabled = true;
    title.innerHtml = "  "+window.sessionStorage['project$i'];
    table.innerHtml = "";
    folderPathBox.value = "";
    String projectName = window.sessionStorage['project$i'];
    ServerRequest.showProjectFolders(window.sessionStorage['username'],window.sessionStorage['password'], projectName, 
                                     "BuildTables", ServerRequest.defaultUri());
  }
  
  void selectFolderDestination(int i)
  {
    OutputElement output = querySelector("#projectSelected");
    String projectName = output.innerHtml;
    InputElement folderPathBox = querySelector("#folderPath");
    String projectPath = projectName+"/"+window.sessionStorage['folderName$i'];
    folderPathBox.value = projectName+"/"+window.sessionStorage['folderName$i'];
    window.sessionStorage['filePath'] = projectPath;
    ServerRequest.showProjectFiles(window.sessionStorage['username'],window.sessionStorage['password'], projectPath, 
                                     "*", ServerRequest.defaultUri());
  }
  
  void selectFileDestination(int fileNum, int fileLength)
  {
    TableCellElement clickedcell = querySelector("#file$fileNum");
    InputElement folderPathBox = querySelector("#folderPath");
    ButtonElement ok = querySelector("#okExplorer"); 
    String path = window.sessionStorage['filePath'];
    for(int i = 0; i < fileLength; i++)
    {
      if(i == fileNum)
      {
        clickedcell.style.backgroundColor = "#CDE7F0";
        folderPathBox.value = path+"/"+window.sessionStorage['projectfile$fileNum'];
        window.sessionStorage['finishedFilePath'] = folderPathBox.value;
        ok.disabled = false;
      }
      else if(i != fileNum)
      {
        TableCellElement unclickedFile = querySelector("#file$i");
        unclickedFile.style.backgroundColor = "";
      }
    }
  }
  
  setItem(MouseEvent m)
  {
    InputElement pathBox = querySelector("#folderPath");
    window.localStorage['finishedFilePath'] = pathBox.value;
    window.close();     
  }
  
  showStorage(Event e)
  {
    InputElement browseBox = querySelector("#browseText");
    browseBox.value = window.localStorage['finishedFilePath'].trim();
  }
}