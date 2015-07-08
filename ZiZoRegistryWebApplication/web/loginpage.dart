import 'dart:html';
import 'navigationfunctions.dart';
import 'popupconstruct.dart';

void main() 
{
  PopupWindow p = new PopupWindow();
  NavigationFunctions navigate = new NavigationFunctions();
  querySelector("#submitButton").onClick.listen(navigate.login);
  querySelector("#dismissFinal").onClick.listen(p.dismissPrompt);
}
