
{
Sample dark themeBase implementation for custom themes

1. Save copy with other unit name
2. Change colors and settings

}
unit sgj.win32styles.themes.dark;

{$mode ObjFPC}{$H+}

interface

uses
  Graphics, SysUtils,
  SGJ.Win32Styles.Themes;

Procedure CS_SetColors;
implementation

procedure CS_SetColors;
begin
   CS_ENABLE:=true;  //enable theme
  //Win10 17763+
   CS_DarkTitleBar:=false; //Enable native Windows Dark Mode Title bar
   CS_ForceDark:=true;     //Enable native dark context menu for edit, memo...


   CS_TitleBar_Font:= clWhite;  //DWM COLOR only on Win11 b22000+

   //DWM COLOR only on Win11 b22000+ //
   //if CS_NoDWMForOldOS=true, its used for Aero Basic Mode
   //if Win 10 17763+ and CS_DarkTitleBar = true -> ignored
   CS_TitleBar_Color:= RGBToColor(63, 63, 63);  //Custom Colors if CS_DarkTitleBar=false
   CS_TitleBar_BORDER:= RGBToColor(63, 63, 63); //Custom Colors if CS_DarkTitleBar=false

   //This Work on Vista/7/8.x with Aero Basic Theme
   CS_NoDWMForOldOS:= true; //Enable old Aero Basic mode for Window on Windows < 10 b17763
   //End


   CS_FORM_COLOR_DEFAULT:=RGBToColor(53, 53, 53);
   CS_FORM_FONT_DEFAULT :=clWhite;                //Windows 11, SysMenu and edit/memo menus inherit this font color

   CTRL_Border:= RGBToColor(92, 92, 92);
   CTRL_Border2:=RGBToColor(42, 42, 42);
   CS_HIGHLIGHT:=RGBToColor(93, 93, 93);

   //PROGRESS
   CS_PROGRESS_FRAME:= RGBToColor(92, 92, 92);                 //Progress Border
   CS_PROGRESS_BACKGROUND:= RGBToColor(53, 53, 53);            //Progress Background
   CS_PROGRESS_Fill_1:= RGBToColor(62, 62, 62);                //Fill gradient, clNone
   CS_PROGRESS_Fill_2:= RGBToColor(22, 22, 22);                 // for os default
   //BP_PUSHBUTTON
   CS_BUTTON_PUSHBUTTON_NORMAL:=RGBToColor(53, 53, 53);             //Button Normal
   CS_BUTTON_PUSHBUTTON_FRAME_NORMAL:=RGBToColor(63, 63, 63);     //Button Border
   CS_BUTTON_PUSHBUTTON_HOT:= RGBToColor(73, 73, 73);          // HOT
   CS_BUTTON_PUSHBUTTON_FRAME_HOT:= RGBToColor(63, 63, 63);        // --
   CS_BUTTON_PUSHBUTTON_PRESSED:= RGBToColor(43, 43, 43);           // Pressed
   CS_BUTTON_PUSHBUTTON_FRAME_PRESSED:= RGBToColor(63, 63, 63);    // --
   CS_BUTTON_PUSHBUTTON_DISABLED:= RGBToColor(42, 42, 42);             // Disabled
   CS_BUTTON_PUSHBUTTON_FRAME_DISABLED:= RGBToColor(63, 63, 63);      // --
   CS_BUTTON_PUSHBUTTON_DEFAULTED:= RGBToColor(73, 73, 73);
   CS_BUTTON_PUSHBUTTON_FRAME_DEFAULTED:= RGBToColor(63, 63, 63);
   CS_BUTTON_PUSHBUTTON_Font:= clwhite;                //Font Normal
   CS_BUTTON_PUSHBUTTON_Font_DISABLED:= clGray;        //Font Disabled


   //BP_CHECKBOX
   //BP_CHECKBOX
    if Win32MajorVersion=5 then
    CS_BUTTON_CHECKBOX_Color:= CS_FORM_COLOR_DEFAULT;    //For XP compatibility, text background
    CS_BUTTON_CHECKBOX_Font:= clWhite;             // Font color
    CS_BUTTON_CHECKBOX_DISABLED_FONT:= clGray;     // --||--    Disabled
    CS_BUTTON_CHECKBOX:= clWhite;                  // Inner Color
    CS_BUTTON_CHECKBOX_DISABLED:= clGray;          // --||--    Disabled
    CS_BUTTON_CHECKBOX_State:= clBlack;            // State Color
    CS_BUTTON_CHECKBOX_State_DISABLED:= clWhite;   // --||--    Disabled
    CS_BUTTON_CHECKBOX_Border:= clBlack;           // Border Color
    CS_BUTTON_CHECKBOX_Border_DISABLED:= clGray;   // --||--     Disabled
    CS_BUTTON_CHECKBOX_Border_HOT:= clBlack;       // --||--     Hot

    //BP_RADIOBUTTON
    CS_BUTTON_RADIOBUTTON:= clWhite;                // Inner Color
    CS_BUTTON_RADIOBUTTON_CHECKED:= RGBToColor(92, 92, 92);       // --||--     Checked
    CS_BUTTON_RADIOBUTTON_DISABLED:=clGray;         // --||--     Disabled
    CS_BUTTON_RADIOBUTTON_State:= clWhite;          // State Color
    CS_BUTTON_RADIOBUTTON_Border:= clWhite;         // Border Color
    CS_BUTTON_RADIOBUTTON_Border_HOT:= RGBToColor(72, 72, 72);       // --||--     Hot
    CS_BUTTON_RADIOBUTTON_Border_DISABLED:= clGray; // --||--     Disabled
    CS_BUTTON_RADIOBUTTON_Border_Pressed:= RGBToColor(92, 92, 92); // --||--     Pressed
    CS_BUTTON_RADIOBUTTON_Font:= clWhite;           // Font color
    CS_BUTTON_RADIOBUTTON_Font_DISABLED:= clGray;   // --||--    Disabled

    CS_BUTTON_GROUPBOX_Font:= clWhite;              // GroupBox Font
    CS_BUTTON_GROUPBOX_Border:= RGBToColor(92, 92, 92);            // GroupBox Border

    //StatusBar
    CS_STATUSBAR_Color:= RGBToColor(40, 40, 40);                  // Background Gradient 1
    CS_STATUSBAR_Color2:= RGBToColor(20, 20, 20);                 // Background Gradient 2
    CS_STATUSBAR_Font:= clWhite;                 // Font Color
    CS_STATUSBAR_Panel_Separator:= RGBToColor(53, 53, 53) ;      // Separator


    //Trackbar
    CS_TRACKBAR_TRACK_BACKGROUND:= RGBToColor(53, 53, 53) ;       // Background
    CS_TRACKBAR_TRACK_FRAME:= RGBToColor(92, 92, 92);             // Border
    CS_TRACKBAR_THUMB_BACKGROUND_NORMAL:= RGBToColor(40, 40, 40); // Thumb
    CS_TRACKBAR_THUMB_FRAME_NORMAL:= RGBToColor(92, 92, 92);      // Thumb
    CS_TRACKBAR_THUMB_BACKGROUND_PRESSED:= clGray; // Thumb
    CS_TRACKBAR_THUMB_FRAME_PRESSED:= clGray;      // Thumb
    CS_TRACKBAR_THUMB_BACKGROUND_HOT:= clBlack;    // Thumb
    CS_TRACKBAR_THUMB_FRAME_HOT:= clblack;         // Thumb
    CS_TRACKBAR_THUMB_BACKGROUND_FOCUSED:= clblack;// Thumb
    CS_TRACKBAR_THUMB_FRAME_FOCUSED:= clblack;     // Thumb
    CS_TRACKBAR_THUMB_BACKGROUND_DISABLED:= clGray;// Thumb
    CS_TRACKBAR_THUMB_FRAME_DISABLED:= clGray;     // Thumb

    //Tooltip - Hint
    CS_TOOLTIP_FONT:= clBlack;           // Font
    CS_TOOPTIP_FRAME:= RGBToColor(92, 92, 92);         // Border
    CS_TOOLTIP_BACKGROUND:= RGBToColor(142, 142, 142);    // BackGround


    //MEMO
    CS_MEMO_COLOR:= RGBToColor(42, 42, 42);
    CS_MEMO_TEXT:= clWhite;
    // EDIT
    CS_EDIT_INNER_BORDER:= RGBToColor(42, 42, 42);
    CS_EDIT_INNER_BACKGROUND_NORMAL:= RGBToColor(42, 42, 42);
    CS_EDIT_INNER_BACKGROUND_HOT:= RGBToColor(42, 42, 42);
    CS_EDIT_INNER_BACKGROUND_DISABLED:= RGBToColor(42, 42, 42);
    CS_EDIT_INNER_BACKGROUND_FOCUSED:= RGBToColor(42, 42, 42);
    CS_EDIT_INNER_BACKGROUND_READONLY:= RGBToColor(42, 42, 42);
    CS_EDIT_INNER_BACKGROUND_ASSIST:= RGBToColor(42, 42, 42);
    CS_EDIT_OUTER_BACKGROUND:= RGBToColor(42, 42, 42);
    CS_EDIT_OUTER_BORDER:= RGBToColor(92, 92, 92);

    //ListBox
    CS_LISTBOX:= RGBToColor(92, 92, 92);  //Combobox frame
    CS_LISTBOX_COLOR:= RGBToColor(42, 42, 42);
    CS_LISTBOX_FONT:= clWhite;


    //ListView
    CS_LISTVIEW_BACKGROUND:= RGBToColor(42, 42, 42);
    CS_LISTVIEW_TEXT:= clWhite;
    CS_LISTVIEW_Header_Font:= clWhite;
    CS_LISTVIEW_ITEM_HOT:=  $909090;
    CS_LISTVIEW_ITEM_HOT_BORDER:= clBtnShadow;
    CS_LISTVIEW_ITEM_SELECTED:= $707070;
    CS_LISTVIEW_ITEM_SELECTED_BORDER:= clBtnShadow;
    //TreeView
    CS_TREEVIEW_FONT:= clWhite;
    CS_TREEVIEW_BACKGROUND:= RGBToColor(42, 42, 42);
    CS_TREEVIEW_ITEM_HOT:= $909090;
    CS_TREEVIEW_ITEM_HOT_BORDER:= clBtnShadow;
    CS_TREEVIEW_ITEM_SELECTED:= $707070;
    CS_TREEVIEW_ITEM_SELECTED_BORDER:= clBtnShadow;


      //Header
  CS_HEADER_FONT:= clWhite;
  CS_HEADER_ITEM_NORMAL:= $909090;
  CS_HEADER_ITEM_NORMAL2:= $707070;
  CS_HEADER_ITEM_HOT:= $00808080;
  CS_HEADER_ITEM_HOT2:= $00808080;
  CS_HEADER_ITEM_PRESSED:= $00909090;
  CS_HEADER_ITEM_PRESSED2:= $00909090;
  CS_HEADER_BORDER_RIGHT:= RGBToColor(42, 42, 42);
  CS_HEADER_BORDER_TOP:= RGBToColor(42, 42, 42);
  CS_HEADER_BORDER_BOTTOM:= RGBToColor(42, 42, 42);

  //ComboBox
  CS_COMBOBOX_BACKGROUND:= RGBToColor(42, 42, 42);
  CS_COMBOBOX_TEXT:= clWhite;
  CS_COMBOBOX_Normal:= RGBToColor(42, 42, 42);
  CS_COMBOBOX_Frame:= RGBToColor(92, 92, 92);
  CS_COMBOBOX_Frame_Hot:= RGBToColor(42, 42, 42);;
  CS_COMBOBOX_Frame_Disabled:= clGray;
  //Readonly = list mode
  CS_COMBOBOX_READONLY_Frame:= RGBToColor(92, 92, 92);
  CS_COMBOBOX_READONLY_Normal:= RGBToColor(42, 42, 42);
  CS_COMBOBOX_READONLY_HOT:= RGBToColor(82, 82, 82);
  CS_COMBOBOX_READONLY_HOT_FRAME:= RGBToColor(92, 92, 92);
  CS_COMBOBOX_READONLY_Pressed:= RGBToColor(72, 72, 72);
  CS_COMBOBOX_READONLY_PRESSED_FRAME:= RGBToColor(82, 82, 82);
  CS_COMBOBOX_READONLY_Disabled:= clGray;
  CS_COMBOBOX_READONLY_DISABLED_FRAME:= clGray;
  //Text on dropdown = arrow
  CS_COMBOBOX_DROPDOWNBUTTON_DISABLED_FONT:= clBlack;
  CS_COMBOBOX_DROPDOWNBUTTON_DISABLED_BACKGROUND:= clGray;
  CS_COMBOBOX_DROPDOWNBUTTON_HOT_FONT:= clWhite;
  CS_COMBOBOX_DROPDOWNBUTTON_HOT_BACKGROUND:= RGBToColor(82, 82, 82);;
  CS_COMBOBOX_DROPDOWNBUTTON_PRESSED_FONT:= clWhite;
  CS_COMBOBOX_DROPDOWNBUTTON_PRESSED_BACKGROUND:= RGBToColor(72, 72, 72);


  //SPIN
  CS_SPIN_NORMAL:= RGBToColor(53, 53, 53);
  CS_SPIN_NORMAL_FRAME:= RGBToColor(92, 92, 92);
  CS_SPIN_HOT:= RGBToColor(73, 73, 73);
  CS_SPIN_HOT_FRAME:= RGBToColor(92, 92, 92);
  CS_SPIN_PRESSED:= RGBToColor(43, 43, 43);
  CS_SPIN_PRESSED_FRAME:= RGBToColor(92, 92, 92);
  CS_SPIN_DISABLED:= clGray;
  CS_SPIN_DISABLED_FRAME:= RGBToColor(92, 92, 92);
  CS_SPIN_ARROW:= clWhite;

  //TOOLBAR
  CS_TOOLBAR_FONT:= clWhite;
  CS_TOOLBAR_BACKGROUND:= RGBToColor(40, 40, 40);
  CS_TOOLBAR_BACKGROUND2:= RGBToColor(20, 20, 20);
  CS_TOOLBAR_SEPARATOR:= RGBToColor(92, 92, 92);
  CS_TOOLBAR_DROPDOWN_ARROW:= clWhite;
  CS_TOOLBAR_BUTTON_NORMAL:= RGBToColor(40, 40, 40);
  CS_TOOLBAR_BUTTON_NORMAL_FRAME:= RGBToColor(92, 92, 92);
  CS_TOOLBAR_BUTTON_PRESSED:= RGBToColor(60, 60, 60);
  CS_TOOLBAR_BUTTON_PRESSED_FRAME:= RGBToColor(92, 92, 92);
  CS_TOOLBAR_BUTTON_HOT:= RGBToColor(50, 50, 50);     //Default on non Flat ToolBar
  CS_TOOLBAR_BUTTON_HOT_FRAME:= RGBToColor(92, 92, 92);
  CS_TOOLBAR_BUTTON_DISABLED:= clGray;
  CS_TOOLBAR_BUTTON_DISABLED_FRAME:= RGBToColor(92, 92, 92);
  CS_TOOLBAR_BUTTON_CHECKED:= RGBToColor(60, 60, 60);
  CS_TOOLBAR_BUTTON_CHECKED_FRAME:= RGBToColor(92, 92, 92);
  CS_TOOLBAR_BUTTON_NEARHOT:= $00404040;
  CS_TOOLBAR_BUTTON_NEARHOT_FRAME:= RGBToColor(92, 92, 92);
  CS_TOOLBAR_BUTTON_HOTCHECKED:= $00505050;
  CS_TOOLBAR_BUTTON_HOTCHECKED_FRAME:= RGBToColor(92, 92, 92);
  CS_TOOLBAR_BUTTON_OTHERSIDEHOT:= $00353535;
  CS_TOOLBAR_BUTTON_OTHERSIDEHOT_FRAME:= RGBToColor(92, 92, 92);


  //SCROLL
  CS_SCROLL_BACKGROUND:= RGBToColor(42, 42, 42);
  CS_SCROLL_ARROW_NORMAL:= clblack;
  CS_SCROLL_ARROW_HOT:= clGray;
  CS_SCROLL_ARROW_DISABLED:= clGray;
  CS_SCROLL_ARROW_BACKGROUND:= RGBToColor(42, 42, 42);
  CS_SCROLL_GRIP_NORMAL:=RGBToColor(90, 90, 90);
  CS_SCROLL_GRIP_HOT:= RGBToColor(70, 70, 70);
  CS_SCROLL_GRIP_DISABLED:= clGray;
  CS_SCROLL_GRIP_NORMAL_FRAME:= RGBToColor(92, 92, 92);
  CS_SCROLL_GRIP_HOT_FRAME:= RGBToColor(92, 92, 92);
  CS_SCROLL_GRIP_DISABLED_FRAME:= clGray;

  //TAB
  CS_TAB_FONT:= clWhite;
  CS_TAB_PANE_BACKGROUND:= RGBToColor(53, 53, 53);
  CS_TAB_PANE_BORDER:= RGBToColor(92, 92, 92);
  CS_TAB_ITEM_HOT_BACKGROUND:= RGBToColor(73, 73, 73);
  CS_TAB_ITEM_HOT_FRAME:= RGBToColor(92, 92, 92);
  CS_TAB_ITEM_NORMAL_BACKGROUND:= RGBToColor(53, 53, 53);
  CS_TAB_ITEM_NORMAL_FRAME:= RGBToColor(92, 92, 92);
  CS_TAB_ITEM_SELECTED_BACKGROUND:= RGBToColor(43, 43, 43);
  CS_TAB_ITEM_SELECTED_FRAME:= RGBToColor(92, 92, 92);
  CS_TAB_ITEM_DISABLED_BACKGROUND:= clGray;
  CS_TAB_ITEM_DISABLED_FRAME:= RGBToColor(92, 92, 92);
  CS_TAB_ITEM_FOCUSED_BACKGROUND:= RGBToColor(73, 73, 73);
  CS_TAB_ITEM_FOCUSED_FRAME:= RGBToColor(92, 92, 92);

  //Menus
  CS_MENU_FONT:= clWhite;                             // Menu Font Color
  CS_MENU_BACKGROUND:= RGBToColor(40, 40, 40);                     // MainMenu Gradient 1
  CS_MENU_BACKGROUND2:= RGBToColor(20, 20, 20);                    // MainMenu Gradient 2
  CS_MENU_ITEM_NORMAL:= RGBToColor(40, 40, 40);                    // Main Menu Item Gradient 1
  CS_MENU_ITEM_NORMAL2:= RGBToColor(20, 20, 20);                   // Main Menu Item Gradient 2
  CS_MENU_ITEM_HOT:= RGBToColor(50, 50, 50);
  CS_MENU_ITEM_HOT2:= RGBToColor(30, 30, 30);
  CS_MENU_ITEM_PUSHED:= RGBToColor(60, 60, 60);
  CS_MENU_ITEM_PUSHED2:= RGBToColor(40, 40, 40);
  CS_MENU_ITEM_DISABLED:= RGBToColor(40, 40, 40);;
  CS_MENU_ITEM_DISABLED2:= RGBToColor(20, 20, 20);;
  CS_MENU_ITEM_DISABLED_FONT:= clGray;
  CS_POPUPMENU_FONT:= clWhite;
  CS_POPUPMENU_BACKGROUND:= RGBToColor(40, 40, 40);
  CS_POPUPMENU_BORDER:= RGBToColor(40, 40, 40);
  CS_POPUPMENU_ITEM_NORMAL:= RGBToColor(40, 40, 40);
  CS_POPUPMENU_ITEM_HOT:= RGBToColor(93, 93, 93);
  CS_POPUPMENU_ITEM_DISABLED:= clGray;
  CS_POPUPMENU_GUTTER:= RGBToColor(40, 40, 40);
  CS_POPUPMENU_SEPARATOR:= clgray;
  CS_POPUPMENU_POPUPCHECK:= clWhite;
  CS_POPUPMENU_POPUPCHECK_FRAME:= RGBToColor(40, 40, 40);
  CS_POPUPMENU_POPUPCHECK_BACKGROUND:= RGBToColor(40, 40, 40);
  CS_POPUPMENU_POPUPSUBMENU:= clWhite;
end;

end.




