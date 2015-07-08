import 'dart:html';
import 'helpscreen.dart';
import 'navigationfunctions.dart';

void main()
{
  NavigationFunctions navigate = new NavigationFunctions();
  HelpScreen h = new HelpScreen();
  querySelector("#homePage").onClick.listen(navigate.goToHomePage);
  querySelector("#helpButton").onClick.listen(h.showHelpPage);
  querySelector("#logOut").onClick.listen(navigate.logout);
  querySelector("#usernameOutput").innerHtml = window.sessionStorage['username'];
}
