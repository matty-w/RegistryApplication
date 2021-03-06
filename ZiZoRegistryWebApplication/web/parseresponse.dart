library parse;

import 'parseinterior.dart';
import 'dart:html';

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
  
  static List parseFolderNames(String startTag, String endTag, String startTag2, String endTag2, String text)
  {
    List folderTrim1 = new List<String>();
    List folderTrim2 = new List<String>();
    List folderTrim3 = new List<String>();
    List folders = text.split(startTag);
    folderTrim1 = ParseInterior.splitTag(folders, startTag, endTag);
    folderTrim2 = ParseInterior.parseSecondTag(folderTrim1, startTag2);
    folderTrim3 = ParseInterior.parseFinalFolder(folderTrim2, endTag2);
    for(int i = 0; i < folderTrim3.length; i++)
    {
      window.sessionStorage['folderName$i'] = folderTrim3[i];
    }
    return folderTrim3;
  }
  
  static List parseFileNames(String startTag, String endTag, String startTag2, String endTag2, String text)
  {
    List fileTrim1 = new List<String>();
    List fileTrim2 = new List<String>();
    List fileTrim3 = new List<String>();
    List fileFinal = new List<String>();
    List files = text.split(startTag);
    fileTrim1 = ParseInterior.splitTag(files, startTag, endTag);
    fileTrim2 = ParseInterior.parseSecondTag(fileTrim1, startTag2);
    fileTrim3 = ParseInterior.parseFinalFile(fileTrim2, endTag2);
    for(int i = 0; i < fileTrim3.length; i++)
    {
      String option = fileTrim3[i];
      if(option.contains("entity.name"))
      {
        String fileName = option.substring(12);
        fileFinal.add(fileName);
      }
    }
    for(int i = 0; i < fileFinal.length; i++)
    {
      window.sessionStorage['projectfile$i'] = fileFinal[i];
    }
    return fileFinal;
  }
  
  static List parse(String startTag, String endTag, String text) 
  {
    List<String> projects = new List<String>();
    List projs = text.split(startTag);
    projects = ParseInterior.parseProject(projs, endTag);
    return projects;
   }
}