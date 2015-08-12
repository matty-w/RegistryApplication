library popup;

import 'dart:html';

String licenceName;

class PopupWindow
{
  Rectangle blanketSize(String popupId)
  {
    int viewportHeight, blanketHeight, popupHeight;
    HtmlHtmlElement frame = document.body.parentNode;
    viewportHeight = window.innerHeight;
    
    if ((viewportHeight > frame.scrollHeight) && (viewportHeight > frame.clientHeight))
      blanketHeight = viewportHeight;
    else if(frame.clientHeight > frame.scrollHeight)
      blanketHeight = frame.clientHeight;
    else
      blanketHeight = frame.scrollHeight;
    
    DivElement blanket = querySelector('#blanket');
    blanket.style.height = blanketHeight.toString() + 'px';
    DivElement popUpDiv = querySelector(popupId);
    popupHeight = (blanketHeight/2-200).floor();
    popUpDiv.style.top = popupHeight.toString() + 'px';
   
    return new Rectangle(0, 0, 0, viewportHeight);
  }
  
  void hideButtons(bool dismissFail, bool dismissSuccess, bool dismissFinal, bool clipboard)
  {
    ButtonElement button1 = querySelector("#no");
    ButtonElement button2 = querySelector("#yes");
    ButtonElement button3 = querySelector("#dismissFinal");
    ButtonElement button4 = querySelector("#clipboard");

    
    button1.hidden = dismissFail;
    button2.hidden = dismissSuccess;
    button3.hidden = dismissFinal;
    button4.hidden = clipboard; 

  }
  
  void dismiss(String popupId)
  {
    hide("#blanket");
    hide(popupId);
  }
  
  void dismissPrompt(MouseEvent e)
  {
    dismiss("#popUpDiv");
  }
  
  String getLicenceName()
  {
    return licenceName;
  }
  
  void getResult(Function popup, String response)
  {
    OutputElement output = querySelector("#serverResponse");
    output.innerHtml = response;
    licenceName = response;
    popup; 
  }
  
  void hide(div_id)
  {
    DivElement el = querySelector(div_id);  
    el.style.display = "none";   
  }
  
  popup(String popupId)
  {
    blanketSize(popupId);
    windowPosition(popupId);
    show('#blanket');
    show(popupId); 
  }
  
  void setErrorPicture(bool a)
  {
    if(a == true)
      querySelector("#tick").setAttribute("src", "images/dialogWarning2.png");
    else
      querySelector("#tick").setAttribute("src", "images/ticksmall.png");
  }
  
  void setFailText(String title, String description)
  {
    querySelector("#popupTitle").innerHtml = title;
    OutputElement text = querySelector("#popupText");
    text.innerHtml = description;
  }
  
  void setText(String option)
  {
    String title;
    String description;
    
    if(option == "no-username")
    {
      title = "Error";
      description = "No Username Entered, Please Enter A Username.";
      querySelector("#popupTitle").innerHtml = title;
      OutputElement server = querySelector("#serverResponse");
      server.innerHtml = "";
      OutputElement text = querySelector("#popupText");
      text.innerHtml = description;
    }
    if(option == "no-password")
    {
      title = "Error";
      description = "Password Not Entered, Please Enter A Password.";
      querySelector("#popupTitle").innerHtml = title;
      OutputElement server = querySelector("#serverResponse");
      server.innerHtml = "";
      OutputElement text = querySelector("#popupText");
      text.innerHtml = description;
    }
    if(option == "details-incorrect")
    {
      title = "Error";
      description = "The Details Entered Are Incorrect, Please Try Again.";
      querySelector("#popupTitle").innerHtml = title;
      OutputElement server = querySelector("#serverResponse");
      server.innerHtml = "";
      OutputElement text = querySelector("#popupText");
      text.innerHtml = description;
    }
    if(option == "no-registries")
    {
      title = "Error";
      description = "The Project "+"'"+window.sessionStorage['project']+"'"+
          " Does Not Contain Any Registries, Please Select Another";
      querySelector("#popupTitle").innerHtml = title;
      OutputElement server = querySelector("#serverResponse");
      server.innerHtml = "";
      OutputElement text = querySelector("#popupText");
      text.innerHtml = description;
    }
    if(option == "add-registry")
    {
      title = "Add Registry Entry";
      description = "Please Type The Name Of The Registry Entry You Wish To Create";
      querySelector("#popupTitle").innerHtml = title;
      OutputElement server = querySelector("#serverResponse");
      server.innerHtml = "";
      OutputElement text = querySelector("#popupText");
      text.innerHtml = description;
    }
    if(option == "list-files")
    {
      title = "Delete Entries?";
      querySelector("#popupTitle").innerHtml = title;
    }
    if(option == "delete-success")
    {
      title = "Delete Completed";
      description = "The Registry Entrties Were Successfully Deleted";
      querySelector("#popupTitle").innerHtml = title;
      OutputElement text = querySelector("#popupText");
      text.innerHtml = description;
    }
  }
  
  void setList(List filesForDeletion)
  {
    OutputElement text = querySelector("#popupText");
    String endList = "";
    String currentText;
    int num = 1;
    for(int i = 0; i < filesForDeletion.length; i++)
    {
      currentText = "Key "+num.toString()+": "+filesForDeletion[i]+" ";
      endList = endList+currentText;
      num++;
    }
    text.innerHtml = endList;
  }
  
  void setXmlResponse(String response)
  {
    String title = "Response";
    String description = "The Server Responds With: ";
    OutputElement server = querySelector("#serverResponse");
    querySelector("#popupTitle").innerHtml = title;
    server.innerHtml = response;
    OutputElement text = querySelector("#popupText");
    text.innerHtml = description;  
  }
  
  void show(div_id)
  {
    DivElement el = querySelector(div_id);  
    el.style.display = "block";  
  }

  Point windowPosition(String popupId)
  {
    int windowWidth;
    int viewportWidth = window.innerHeight;
    HtmlHtmlElement frame = document.body.parentNode;
    
    if ((viewportWidth > frame.scrollWidth) && (viewportWidth > frame.clientWidth))
      windowWidth = viewportWidth;
    else if(frame.clientWidth > frame.scrollWidth)
      windowWidth = frame.clientWidth;
    else
      windowWidth = frame.scrollWidth;
       
    DivElement popUpDiv = querySelector(popupId);
    windowWidth = (windowWidth/2-200).floor();
    popUpDiv.style.left = windowWidth.toString() + 'px';
    
    return new Point(windowWidth, 0);
  }
}
  

  

  

  

