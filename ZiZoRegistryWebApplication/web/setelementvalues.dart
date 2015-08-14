library setElements;

import 'dart:html';
import 'createtable.dart';
import 'parseresponse.dart';

class SetElementValues
{
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