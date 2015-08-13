library parseInterior;

class ParseInterior
{
  static List splitTag(List registries, String startTag, String endTag)
  {
    List registryList = new List();
    for(int i = 0; i < registries.length; i++)
    {
      if(registries.elementAt(i) != null && registries.elementAt(i).length > 0 && registries.elementAt(i).contains(endTag))
      {
        int index = registries.elementAt(i).indexOf(endTag);
        String reg = registries.elementAt(i).substring(0, index);
        registryList.add(reg);
      }
      else
      {
        registries.remove(i);
      }
    }
    return registryList;
  }
  
  static List parseSecondTag(List registriesListTrim1, String startTag2)
  {
    List registryList = new List();
    for(int i2 = 0; i2 < registriesListTrim1.length; i2++)
    {
      List someRegistry = registriesListTrim1[i2].split(startTag2);
      for(int i3 = 0; i3 < someRegistry.length; i3++)
      {
        if(someRegistry[i3].trim() != "")
        {
          registryList.add(someRegistry[i3]);
        }
        else
        {
          someRegistry.remove(i3);
        }
      }
    }
    return registryList;
  }
  
  static List parseFinalRegistry(List registriesListTrim2, String endTag2)
  {
    List registryList = new List();
    for(int i4 = 0; i4 < registriesListTrim2.length; i4++)
    {
      int index = registriesListTrim2.elementAt(i4).indexOf(endTag2);
      String reg = registriesListTrim2.elementAt(i4).substring(11, index);
      registryList.add(reg);
    }
    return registryList;
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