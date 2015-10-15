library setElements;

import 'dart:html';
import 'createtable.dart';
import 'parseresponse.dart';
import 'serverfunctions.dart';

class SetElementValues
{
  static void getProjects(List projects)
  {
    List<String> projectList = new List();
    projectList = projects;
    window.sessionStorage['projectsLength'] = projects.length.toString();
    for(int i = 0; i <= projectList.length; i++)
    {
      SelectElement select = querySelector("#projectDropDown");
      var option = document.createElement("OPTION");
      option.setAttribute("value", projectList[i]);
      option.setInnerHtml(projectList[i]);
      select.append(option);
      OptionElement o = option;
      if(o.value == window.localStorage['project'])
      {
        o.selected = true;
      }
    }
  }
  
  static void setProjectExplorerList(int projectLength)
  {   
    ServerFunctions sf = new ServerFunctions();
    
    for(int i = 0; i < projectLength; i++)
    {
      TableElement table = querySelector("#projectNames");
      TableRowElement row = table.insertRow(0);
      TableCellElement projectName = row.insertCell(0);
      TableCellElement pictureCell = row.insertCell(0);
      pictureCell.id = "folderPic$i";
      pictureCell.style.verticalAlign = "top";
      pictureCell.style.maxWidth = "8px";
      pictureCell.style.display = "inline-table";
      pictureCell.innerHtml = '<img alt="folderSmall" src="images/folderSmall.png">';
      projectName.id = "projectName$i";
      pictureCell.onClick.listen((MouseEvent m) => sf.showFolders(i));
      projectName.onClick.listen((MouseEvent m) => sf.showFolders(i));
      projectName.innerHtml = window.sessionStorage['project$i'];
    }
  }
  
  static void setProjectFoldersList(int folderLength)
  {
    ServerFunctions sf = new ServerFunctions();
    TableElement table = querySelector("#projectFolders");
    TableRowElement row = table.insertRow(0);
    for(int i = 0; i < folderLength; i++)
    {
      TableCellElement folder = row.insertCell(0);
      folder.id = "folder$i";
      folder.style.display = "inline-table";
      folder.style.margin = "0 40px";
      folder.innerHtml = '<div id="folderAndTitle"><img alt="folderLarge"'+
                         'src="images/folderLarge.png"><p>'+window.sessionStorage['folderName$i']+'</p></div>';
      folder.onClick.listen((MouseEvent m) => sf.selectFolderDestination(i));    
    }
  }
  
  static void setProjectFilesList(int fileLength)
  {
    ServerFunctions  sf = new ServerFunctions();
    TableElement table = querySelector("#projectFolders");
    table.innerHtml = "";
    TableRowElement row =  table.insertRow(0);
    for(int i = 0; i < fileLength; i++)
    {
      TableCellElement file = row.insertCell(0);
      file.id = "file$i";
      file.style.display = "inline-table";
      file.style.margin = "0 30px";
      file.innerHtml = '<div id="folderAndTitle"><img alt="databasePic"'+
          '              src="images/databasePic.png"><p>'+window.sessionStorage['projectfile$i']+'</p></div>';
      file.onClick.listen((MouseEvent m) => sf.selectFileDestination(i, fileLength));
    }
  }
  
  static void getRegistryEntries(List registries)
  {
    List<String> registryNames = new List();
    List<String> registryPaths = new List();
    TableElement table = querySelector("#registryTable");
    for(int i = 0; i < registries.length; i++)
    {
      if(!(registries[i].toString().indexOf(".", registries[i].toString().indexOf(".") + 1) != -1) && i.isEven)
      {
        registryNames.add(registries[i]);
        registryPaths.add(registries[i+1]);
        i++;
      }
    }
    for(int i2 = 0; i2 < registryNames.length; i2++)
    {
      TableRowElement row = table.insertRow(i2);
      TableCellElement checkboxCell = row.insertCell(-1);
      TableCellElement name = row.insertCell(-1);
      TableCellElement path = row.insertCell(-1);
      checkboxCell.innerHtml = "<input id=checkbox$i2 type='checkbox'>";
      name.text = registryNames[i2];
      path.text = registryPaths[i2];
    }
    CreateTable.createTable();
  }
  
  static List deleteKeys()
  {
    TableElement table = querySelector("#registryTable");
    List<String> catalogueKeys = new List();
    int checkboxLength = table.rows.length;
    for(int i = 0; i < checkboxLength-1; i++)
    {
      CheckboxInputElement checkbox = querySelector("#checkbox$i");
      if(checkbox.checked == true)
      {
        String fileName = ParseResponse.parseFileName(table.rows[i+1].innerHtml);
        catalogueKeys.add(fileName);
      }
    }
    return catalogueKeys;
  }
}