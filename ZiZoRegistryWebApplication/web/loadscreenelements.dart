library elements;

import 'dart:html';
import 'navigationfunctions.dart';
import 'helpscreen.dart';
import 'popupconstruct.dart';
import 'serverrequest.dart';
import 'popupselection.dart';
import 'soaprequest.dart'; 

class LoadScreenElements
{
  String projectsLong;
  List<String> projectList = new List();
  
  void loginPage()
  {
    PopupWindow p = new PopupWindow();
    NavigationFunctions navigate = new NavigationFunctions();
    querySelector("#submitButton").onClick.listen(navigate.login);
    querySelector("#dismissFinal").onClick.listen(p.dismissPrompt);
  }
  
  void registryMain()
  {
    PopupWindow p = new PopupWindow();
    NavigationFunctions navigate = new NavigationFunctions();
    HelpScreen h = new HelpScreen();
    window.onLoad.listen(loadProjects);
    querySelector("#homePageButton").onClick.listen(navigate.goToHomePage);
    querySelector("#helpPageButton").onClick.listen(h.showHelpPage);
    querySelector("#logoutButton").onClick.listen(navigate.logout);
    querySelector("#usernameOutput").innerHtml = window.sessionStorage['username'];
    querySelector("#searchButton").onClick.listen(listenToBox);
    querySelector("#deleteButton").onClick.listen(deleteButton);
    querySelector("#no").onClick.listen(p.dismissPrompt);
    querySelector("#yes").onClick.listen(completeDeletion);
    querySelector("#dismissFinal").onClick.listen(p.dismissPrompt);
  }
  
  void completeDeletion(MouseEvent m)
  {
    List catalogueKeys = deleteKeys();
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
    List catalogueKeys = deleteKeys();
    if(catalogueKeys.length > 0)
    {  
      SelectPopup sp = new SelectPopup();
      sp.popupListFilesForDeletion("list-files", catalogueKeys, "#popUpDiv");
    }
  }
  
  String parseFileName(String fileName)
  {
    int startTrim = fileName.indexOf("</td>");
    String fileName2 = fileName.substring(startTrim);
    String fileName3 = fileName2.substring(9);
    int endTrim = fileName3.indexOf("</td>");
    String fileName4 = fileName3.substring(0, endTrim);
    String finishedFileName = fileName4;
    return finishedFileName;
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
  
  loadProjects(Event e)
  {
    ServerRequest.listProjects(window.sessionStorage['username'],window.sessionStorage['password']
                                ,ServerRequest.defaultUri());
  }
  
  static void getProjects(List projects)
  {
    List<String> projectList = new List();
    projectList = projects;
    for(int i = 0; i <= projectList.length; i++)
    {
      SelectElement select = querySelector("#projectDropDown");
      var option = document.createElement("OPTION");
      option.setAttribute("value", projectList[i]);
      option.setInnerHtml(projectList[i]);
      select.append(option);
    }
  }
  
  static void getRegistryEntries(List registries)
  {
    List<String> registryNames = new List();
    List<String> registryPaths = new List();
    TableElement table = querySelector("#registryTable");
    for(int i = 0; i < registries.length; i++)
    {
      registryNames.add(registries[i]);
      i++;
    }
    for(int i1 = 1; i1 < registries.length; i1++)
    {
      registryPaths.add(registries[i1]);
      i1++;
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
    TableSectionElement header = table.createTHead();
    TableRowElement headerRow = header.insertRow(-1);
    TableCellElement cell = headerRow.insertCell(-1);
    TableCellElement cell2 = headerRow.insertCell(-1);
    TableCellElement cell3 = headerRow.insertCell(-1);
    cell.text = "";
    
    cell.style.backgroundColor = "#5C5CD7";
    cell2.style.backgroundColor = "#5C5CD7";
    cell3.style.backgroundColor = "#5C5CD7";
    cell.style.color = "#F0F2F0";
    cell2.style.color = "#F0F2F0";
    cell3.style.color = "#F0F2F0";
    cell.style.textAlign = "left";
    cell2.style.textAlign = "left";
    cell3.style.textAlign = "left";
    cell2.innerHtml = "Catalogue Key:";
    cell3.innerHtml = "File Path:";
    table.hidden = false;
  }
  
  List deleteKeys()
  {
    TableElement table = querySelector("#registryTable");
    List<String> catalogueKeys = new List();
    int checkboxLength = table.rows.length;
    for(int i = 0; i < checkboxLength-1; i++)
    {
      CheckboxInputElement checkbox = querySelector("#checkbox$i");
      if(checkbox.checked == true)
      {
        String fileName = parseFileName(table.rows[i+1].innerHtml);
        catalogueKeys.add(fileName);
      }
    }
    return catalogueKeys;
  }

  
  
  
  
  
  
  
  
  
  
  
}