import 'dart:html';
import 'loadscreenelements.dart';

void main() 
{
  window.onContentLoaded.listen(refresh);
  refresh(null);
}

void refresh(Event e)
{
  LoadScreenElements pageElements = new LoadScreenElements();
  pageElements.loginPage();
}
