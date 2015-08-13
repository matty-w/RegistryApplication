library parse;

import 'parseinterior.dart';

class ParseResponse
{
  static String parseFileName(String fileName)
  {
    int startTrim = fileName.indexOf("</td>");
    String fileName2 = fileName.substring(startTrim);
    String fileName3 = fileName2.substring(9);
    int endTrim = fileName3.indexOf("</td>");
    String fileName4 = fileName3.substring(0, endTrim);
    String finishedFileName = fileName4;
    return finishedFileName;
  }
  
  static List parseRegistries(String startTag, String endTag, String startTag2, String endTag2, String text)
  {
    List<String> registriesListTrim1 = new List<String>();
    List<String> registriesListTrim2 = new List<String>();
    List<String> registriesFinalList = new List<String>();
    List registries = text.split(startTag);
    registriesListTrim1 = ParseInterior.splitTag(registries, startTag, endTag);
    registriesListTrim2 = ParseInterior.parseSecondTag(registriesListTrim1, startTag2);
    registriesFinalList = ParseInterior.parseFinalRegistry(registriesListTrim2, endTag2);
    return registriesFinalList;
  }
  
  static List parse(String startTag, String endTag, String text) 
  {
    List<String> projects = new List<String>();
    List projs = text.split(startTag);
    projects = ParseInterior.parseProject(projs, endTag);
    return projects;
   }
}