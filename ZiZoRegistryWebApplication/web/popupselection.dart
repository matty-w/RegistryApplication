library selectPopup;

import 'popupconstruct.dart';

class SelectPopup
{
  PopupWindow p = new PopupWindow();
  
  popup(String option, String registryKey, List deletionFiles, bool removePictures, bool setErrorPicture, bool setTextBox
         , bool setSelectBox, bool hideBreaks, bool hideDismissFail, bool hideDismissSuccess, bool hideDismissFinal,
         bool hideAddRegistry, String popupId)
  {
    p.setText(option);
    p.removePictures(removePictures);
    if(removePictures == false)
    {
      p.setErrorPicture(setErrorPicture);
    }
    if(deletionFiles != null)
    {
      p.setList(deletionFiles);
    }
    p.setKeyTextbox(setTextBox);
    if(setTextBox == true && registryKey != null)
    {
      p.setEditKeyText(registryKey);
    }
    p.setSelectPathBox(setSelectBox);
    p.hideBreaks(hideBreaks);
    p.hideButtons(hideDismissFail, hideDismissSuccess, hideDismissFinal, hideAddRegistry);
    p.popup(popupId);
  }
}