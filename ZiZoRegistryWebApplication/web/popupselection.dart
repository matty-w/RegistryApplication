library selectPopup;

import 'popupconstruct.dart';
import 'dart:html';

class SelectPopup
{
  PopupWindow p = new PopupWindow();
  
  popup(String option, bool removePictures, bool setErrorPicture, bool setTextbox, bool setSelectBox, bool hideBreaks,
      bool hideDismissFail, bool hideDismissSuccess, bool hideDismissFinal, bool hideAddRegistry,String popupId)
  {
    p.setText(option);
    p.removePictures(removePictures);
    if(removePictures == false)
    {
      p.setErrorPicture(setErrorPicture);
    }
    p.setKeyTextbox(setTextbox);
    p.setSelectPathBox(setSelectBox);
    p.hideBreaks(hideBreaks);
    p.hideButtons(hideDismissFail, hideDismissSuccess, hideDismissFinal, hideAddRegistry);
    p.popup(popupId);
  }
        
  popupListFilesForDeletion(String option, List deletionFiles, String popupId)
  {
    p.setText(option);
    p.setList(deletionFiles);
    p.setErrorPicture(true);
    p.hideButtons(false, false, true, true);
    p.popup(popupId);
  }
  
  popupEditRegistryEntry(String option)
  {
    
  }
}