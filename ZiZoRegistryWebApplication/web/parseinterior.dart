library parseInterior;

import 'dart:html';

class ParseInterior
{
  static List splitTag(List list, String startTag, String endTag)
  {
    List splitList = new List();
    for(int i = 0; i < list.length; i++)
    {
      if(list.elementAt(i) != null && list.elementAt(i).length > 0 && list.elementAt(i).contains(endTag))
      {
        int index = list.elementAt(i).indexOf(endTag);
        String reg = list.elementAt(i).substring(0, index);
        splitList.add(reg);
      }
      else
      {
        splitList.remove(i);
      }
    }
    return splitList;
  }
  
  static List parseSecondTag(List parsedList, String startTag2)
  {
    List list = new List();
    for(int i2 = 0; i2 < parsedList.length; i2++)
    {
      List someRegistry = parsedList[i2].split(startTag2);
      for(int i3 = 0; i3 < someRegistry.length; i3++)
      {
        if(someRegistry[i3].trim() != "")
        {
          list.add(someRegistry[i3]);
        }
        else
        {
          someRegistry.remove(i3);
        }
      }
    }
    return list;
  }
  
  static List parseFinalRegistry(List parsedList, String endTag2)
  {
    List list = new List();
    for(int i = 0; i < parsedList.length; i++)
    {
      int index = parsedList.elementAt(i).indexOf(endTag2);
      String reg = parsedList.elementAt(i).substring(11, index);
      list.add(reg);
    }
    return list;
  }
  
  static List parseFinalFolder(List parsedList, String endTag2)
  {
    List list = new List<String>();
    for(int i = 0; i < parsedList.length; i++)
    {
      int index = parsedList.elementAt(i).indexOf(endTag2);
      String folder = parsedList.elementAt(i).substring(0, index);
      if(folder.contains("folder.name"))
      {
        String folderName = folder.substring(12);
        list.add(folderName);
      }
    }
    return list;
  }
  
  static List parseFinalFile(List parsedList, String endTag2)
  {
    List list = new List<String>();
    for(int i = 0; i < parsedList.length; i++)
    {
      int index = parsedList.elementAt(i).indexOf(endTag2);
      String file = parsedList.elementAt(i).substring(0, index);
      list.add(file);
    }
    return list;
  }
  
  static List parseProject(List projects, String endTag)
  {
    List projectFinal = new List();
    for(int i = 0; i< projects.length; i++) 
    {
       if(projects.elementAt(i) != null && projects.elementAt(i).length > 0 && projects.elementAt(i).contains(endTag)) 
       {
         int index = projects.elementAt(i).indexOf(endTag);
         String project = projects.elementAt(i).substring(0, index);
         projectFinal.add(project);
       }
       else
       {
         projects.remove(i);
       }
    }
    return projectFinal;
  }
}