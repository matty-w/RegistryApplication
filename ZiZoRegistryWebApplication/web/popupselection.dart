library selectPopup;

import 'popupconstruct.dart';
import 'dart:html';

class SelectPopup
{
  popupSuccess(String option, String popupId)
  {
    PopupWindow p = new PopupWindow();
    p.setText(option);
    p.setErrorPicture(false);
    p.hideButtons(true, true, false, true);
    p.popup(popupId);
  }
  
  popupError(String option, String popupId)
  {
    PopupWindow p = new PopupWindow();
    p.setText(option);
    p.setErrorPicture(true);
    p.hideButtons(true, true, false, true);
    p.popup(popupId);
  }
  
  popupXmlResponse(String response, String popupId)
  {
    PopupWindow p = new PopupWindow();
    p.setXmlResponse(response);
    p.setErrorPicture(true);
    p.hideButtons(true, true, false, true);
    p.popup(popupId);
  }
  
  popupAddRegistryEntry(String option, String popupId)
  {
    PopupWindow p = new PopupWindow();
    p.setText(option);
    p.setErrorPicture(true);
    p.hideButtons(true, true, true, true);
    p.popup(popupId);
  }
  
  popupListFilesForDeletion(String option, List deletionFiles, String popupId)
  {
    PopupWindow p = new PopupWindow();
    p.setText(option);
    p.setList(deletionFiles);
    p.setErrorPicture(true);
    p.hideButtons(false, false, true, true);
    p.popup(popupId);
  }
}