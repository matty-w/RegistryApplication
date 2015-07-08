library selectPopup;

import 'dart:html';
import 'popupconstruct.dart';

class SelectPopup
{
  popupError(String option, String popupId)
  {
    PopupWindow p = new PopupWindow();
    p.setText(option);
    p.setErrorPicture(true);
    p.buttons(true, true, false, true);
    p.popup(popupId);
  }
}