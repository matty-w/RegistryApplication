library table;

import 'dart:html';

class CreateTable
{
  static createTable()
  {
    TableElement table = querySelector("#registryTable");
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
}