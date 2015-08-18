library selectPopup;

import 'popupconstruct.dart';

class SelectPopup
{
  PopupWindow p = new PopupWindow();
  
  popup(String option, bool removePictures, bool setErrorPicture, bool setTextboxes, bool hideDismissFail,
      bool hideDismissSuccess, bool hideDismissFinal, bool hideAddRegistry,String popupId)
  {
    p.setText(option);
    p.removePictures(removePictures);
    if(removePictures == false)
    {
      p.setErrorPicture(setErrorPicture);
    }
    p.setTextboxes(setTextboxes);
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
}