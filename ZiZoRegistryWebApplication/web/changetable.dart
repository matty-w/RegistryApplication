library tables;

import 'dart:html';

class ChangeTable
{ 
  String listenToCombobox()
  {
    InputElement tableChoice = querySelector("#projectDropDown");
    String table;
    table = tableChoice.value;
    if(table == null)
    {
      table = "";
    }
    return table;
  }
  
  void showTable(MouseEvent m)
  {
    TableElement table = querySelector("#registryTable");
    if(listenToCombobox() == "registryTable")
    {
      table.hidden = false;
    }
    else
    {
      table.hidden = true;
    }
  }
  
  void passProjectChoice(String project)
  {
    TableElement table = querySelector("#registryTable");
    //InputElement list = querySelector("#projectDropDown");
    //int arrayLength = list.children.length;   
    
    
    if(project == null)
    {
      project = "";
    }
    
    if(project == "ViperDb")
    {
      table.hidden = false;
    }
    else
    {
      table.hidden = true;
    }
  }
  
  void setTable()
  {
    InputElement project = querySelector("#projectDropDown");
    project.value = window.sessionStorage['project'];
    String chosenProject = project.value;   
    passProjectChoice(chosenProject); 
  }
}