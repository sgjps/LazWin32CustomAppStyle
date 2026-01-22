{
Whats this?
      Basic Style manager for Win32 apps created with Lazarus
      It's override default Window theme parts and states.

      Author: Grzegorz Skulimowski
      Web:    www.hiperapps.com

      License: LGPL with linking exception.




Some part of this code is delivered from uwin32widgetsetdark.pas from
Double Commander  https://github.com/doublecmd/doublecmd


}

unit SGJ.Win32Styles.Themes;

{$mode ObjFPC}{$H+}

interface

uses
  Windows, uxtheme, Themes, jwaWinGDI, Classes, SysUtils, Graphics, BGRABitmap,
  BGRABitmapTypes;

var

  CS_Enable: boolean = false;
  ////Win10 17763+
  CS_DarkTitleBar: boolean = False;
  CS_ForceDark: boolean = False;
  CS_TitleBar_Color: TColor = clNone;   //clNone if not changed
  CS_TitleBar_Font: TColor = clWhite;
  CS_TitleBar_BORDER: TColor = clnone;   //clNone if not changed

  CS_NoDWMForOldOS: boolean = False;
  //Disable DWM for build < 17763  ; work on Vista to Win10

  //Default FORM
  CS_FORM_COLOR_DEFAULT: TColor = clForm;              // Form Color
  CS_FORM_FONT_DEFAULT: TColor = clBlack;              // Form Font Color

  //all ctrls
  CTRL_Border: TColor = $E2E2E2;
  CTRL_Border2: TColor = clWindow;
  CS_HIGHLIGHT: TColor = $D77800;

  //PROGRESS
  CS_PROGRESS_FRAME: TColor = $BCBCBC;                 //Progress Border
  CS_PROGRESS_BACKGROUND: TColor = $E6E6E6;            //Progress Background
  CS_PROGRESS_Fill_1: TColor = clNone;                 //Fill gradient, clNone
  CS_PROGRESS_Fill_2: TColor = clNone;                 // for os default
  //BP_PUSHBUTTON
  CS_BUTTON_PUSHBUTTON_NORMAL: TColor = clBtnFace;             //Button Normal
  CS_BUTTON_PUSHBUTTON_FRAME_NORMAL: TColor = clBtnShadow;     //Button Border
  CS_BUTTON_PUSHBUTTON_HOT: TColor = clBtnHighlight;           // HOT
  CS_BUTTON_PUSHBUTTON_FRAME_HOT: TColor = clBtnShadow;        // --
  CS_BUTTON_PUSHBUTTON_PRESSED: TColor = clHotLight;           // Pressed
  CS_BUTTON_PUSHBUTTON_FRAME_PRESSED: TColor = clBtnShadow;    // --
  CS_BUTTON_PUSHBUTTON_DISABLED: TColor = $F9F9F9;             // Disabled
  CS_BUTTON_PUSHBUTTON_FRAME_DISABLED: TColor = $EDEDED;       // --
  CS_BUTTON_PUSHBUTTON_DEFAULTED: TColor = clBtnHighlight;
  CS_BUTTON_PUSHBUTTON_FRAME_DEFAULTED: TColor = clBtnShadow;
  CS_BUTTON_PUSHBUTTON_Font: TColor = clBlack;                //Font Normal
  CS_BUTTON_PUSHBUTTON_Font_DISABLED: TColor = clGray;        //Font Disabled
  //BP_CHECKBOX
  CS_BUTTON_CHECKBOX_Color: TColor = clForm;          //For XP compatibility
  CS_BUTTON_CHECKBOX_Font: TColor = clBlack;             // Font color
  CS_BUTTON_CHECKBOX_DISABLED_FONT: TColor = clGray;     // --||--    Disabled
  CS_BUTTON_CHECKBOX: TColor = clWhite;                  // Inner Color
  CS_BUTTON_CHECKBOX_DISABLED: TColor = clGray;          // --||--    Disabled
  CS_BUTTON_CHECKBOX_State: TColor = clBlack;            // State Color
  CS_BUTTON_CHECKBOX_State_DISABLED: TColor = clWhite;   // --||--    Disabled
  CS_BUTTON_CHECKBOX_Border: TColor = clBlack;           // Border Color
  CS_BUTTON_CHECKBOX_Border_DISABLED: TColor = clGray;   // --||--     Disabled
  CS_BUTTON_CHECKBOX_Border_HOT: TColor = clBlack;       // --||--     Hot

  //BP_RADIOBUTTON
  CS_BUTTON_RADIOBUTTON: TColor = clWhite;                // Inner Color
  CS_BUTTON_RADIOBUTTON_CHECKED: TColor = $B85F00;        // --||--     Checked
  CS_BUTTON_RADIOBUTTON_DISABLED: TColor = clGray;         // --||--     Disabled
  CS_BUTTON_RADIOBUTTON_State: TColor = clWhite;          // State Color
  CS_BUTTON_RADIOBUTTON_Border: TColor = clBlack;         // Border Color
  CS_BUTTON_RADIOBUTTON_Border_HOT: TColor = clBlue;      // --||--     Hot
  CS_BUTTON_RADIOBUTTON_Border_DISABLED: TColor = clGray; // --||--     Disabled
  CS_BUTTON_RADIOBUTTON_Border_Pressed: TColor = clBlack; // --||--     Pressed
  CS_BUTTON_RADIOBUTTON_Font: TColor = clBlack;           // Font color
  CS_BUTTON_RADIOBUTTON_Font_DISABLED: TColor = clGray;   // --||--    Disabled
  //BP_GROUPBOX
  CS_BUTTON_GROUPBOX_Font: TColor = clBlack;              // GroupBox Font
  CS_BUTTON_GROUPBOX_Border: TColor = $E2E2E2;            // GroupBox Border
  //BP_USERBUTTON
  CS_BUTTON_USERBUTTON_Font: TColor = clBlack;
  //BP_COMMANDLINK
  CS_BUTTON_COMMANDLINK_Font: TColor = clBlack;

  //StatusBar
  CS_STATUSBAR_Color: TColor = clForm;                 // Background Gradient 1
  CS_STATUSBAR_Color2: TColor = clForm;                // Background Gradient 2
  CS_STATUSBAR_Font: TColor = clBlack;                 // Font Color
  CS_STATUSBAR_Panel_Separator: TColor = $E2E2E2;      // Separator

  //Trackbar
  CS_TRACKBAR_TRACK_BACKGROUND: TCOLOR = clWindow;       // Background
  CS_TRACKBAR_TRACK_FRAME: TCOLOR = clBlack;             // Border
  CS_TRACKBAR_THUMB_BACKGROUND_NORMAL: TCOLOR = $D77800; // Thumb
  CS_TRACKBAR_THUMB_FRAME_NORMAL: TCOLOR = $D77800;      // Thumb
  CS_TRACKBAR_THUMB_BACKGROUND_PRESSED: TCOLOR = clGray; // Thumb
  CS_TRACKBAR_THUMB_FRAME_PRESSED: TCOLOR = clGray;      // Thumb
  CS_TRACKBAR_THUMB_BACKGROUND_HOT: TCOLOR = clBlack;    // Thumb
  CS_TRACKBAR_THUMB_FRAME_HOT: TCOLOR = clblack;         // Thumb
  CS_TRACKBAR_THUMB_BACKGROUND_FOCUSED: TCOLOR = clblack;// Thumb
  CS_TRACKBAR_THUMB_FRAME_FOCUSED: TCOLOR = clblack;     // Thumb
  CS_TRACKBAR_THUMB_BACKGROUND_DISABLED: TCOLOR = clGray;// Thumb
  CS_TRACKBAR_THUMB_FRAME_DISABLED: TCOLOR = clGray;     // Thumb

  //Tooltip - Hint
  CS_TOOLTIP_FONT: TColor = clBlack;           // Font       [Not work on treeview]
  CS_TOOPTIP_FRAME: TColor = $E2E2E2;          // Border
  CS_TOOLTIP_BACKGROUND: TColor = clWhite;   // BackGround

  //ReBar
  CS_REBAR_COLOR1: TColor = clForm;
  CS_REBAR_COLOR2: TColor = clForm;

  //MEMO
  CS_MEMO_COLOR: TColor = clWindow;
  CS_MEMO_TEXT: TColor = clBlack;
  // EDIT
  CS_EDIT_INNER_BORDER: TColor = clWindow;
  CS_EDIT_INNER_BACKGROUND_NORMAL: TColor = clWindow;
  CS_EDIT_INNER_BACKGROUND_HOT: TColor = clWindow;
  CS_EDIT_INNER_BACKGROUND_DISABLED: TColor = clWindow;
  CS_EDIT_INNER_BACKGROUND_FOCUSED: TColor = clWindow;
  CS_EDIT_INNER_BACKGROUND_READONLY: TColor = clWindow;
  CS_EDIT_INNER_BACKGROUND_ASSIST: TColor = clWindow;
  CS_EDIT_OUTER_BACKGROUND: TColor = clWindow;
  CS_EDIT_OUTER_BORDER: TColor = $E2E2E2;

  //ListBox
  CS_LISTBOX: TColor = $E2E2E2;  //Combobox frame
  CS_LISTBOX_COLOR: TColor = clred;
  CS_LISTBOX_FONT: TColor = clBlack;

  //ListView
  CS_LISTVIEW_BACKGROUND: TCOLOR = clWindow;
  CS_LISTVIEW_TEXT: TCOLOR = clBlack;
  CS_LISTVIEW_Header_Font: TCOLOR = clBlack;
  CS_LISTVIEW_ITEM_HOT: TColor = clBtnFace;
  CS_LISTVIEW_ITEM_HOT_BORDER: TColor = clBtnShadow;
  CS_LISTVIEW_ITEM_SELECTED: TColor = $707070;
  CS_LISTVIEW_ITEM_SELECTED_BORDER: TColor = clBtnShadow;
  //TreeView
  CS_TREEVIEW_FONT: TCOLOR = clBlack;
  CS_TREEVIEW_BACKGROUND: TCOLOR = clWindow;
  CS_TREEVIEW_ITEM_HOT: TColor = clBtnFace;
  CS_TREEVIEW_ITEM_HOT_BORDER: TColor = clBtnShadow;
  CS_TREEVIEW_ITEM_SELECTED: TColor = $707070;
  CS_TREEVIEW_ITEM_SELECTED_BORDER: TColor = clBtnShadow;

  //Header
  CS_HEADER_FONT: TCOLOR = clBlack;
  CS_HEADER_ITEM_NORMAL: TColor = clWindow;
  CS_HEADER_ITEM_NORMAL2: TColor = clWindow;
  CS_HEADER_ITEM_HOT: TColor = $00808080;
  CS_HEADER_ITEM_HOT2: TColor = $00808080;
  CS_HEADER_ITEM_PRESSED: TColor = $00909090;
  CS_HEADER_ITEM_PRESSED2: TColor = $00909090;
  CS_HEADER_BORDER_RIGHT: TColor = $EFEFEF;
  CS_HEADER_BORDER_TOP: TColor = clWindow;
  CS_HEADER_BORDER_BOTTOM: TColor = clWindow;

  //ComboBox
  CS_COMBOBOX_BACKGROUND: TColor = clWindow;
  CS_COMBOBOX_TEXT: TColor = clBlack;
  CS_COMBOBOX_Normal: TColor = clWindow;
  CS_COMBOBOX_Frame: TColor = $E2E2E2;
  CS_COMBOBOX_Frame_Hot: TColor = $E2E2E2;
  CS_COMBOBOX_Frame_Disabled: TColor = $E2E2E2;
  //Readonly = list mode
  CS_COMBOBOX_READONLY_Frame: TColor = $E2E2E2;
  CS_COMBOBOX_READONLY_Normal: TColor = clBtnFace;
  CS_COMBOBOX_READONLY_HOT: TColor = $DEDEDE;
  CS_COMBOBOX_READONLY_HOT_FRAME: TColor = $E2E2E2;
  CS_COMBOBOX_READONLY_Pressed: TColor = $DEDEDE;
  CS_COMBOBOX_READONLY_PRESSED_FRAME: TColor = $E2E2E2;
  CS_COMBOBOX_READONLY_Disabled: TColor = clGray;
  CS_COMBOBOX_READONLY_DISABLED_FRAME: TColor = clGray;
  //Text on dropdown = arrow
  CS_COMBOBOX_DROPDOWNBUTTON_DISABLED_FONT: TColor = clBlack;
  CS_COMBOBOX_DROPDOWNBUTTON_DISABLED_BACKGROUND: TColor = clGray;
  CS_COMBOBOX_DROPDOWNBUTTON_HOT_FONT: TColor = clWhite;
  CS_COMBOBOX_DROPDOWNBUTTON_HOT_BACKGROUND: TColor = clBlack;
  CS_COMBOBOX_DROPDOWNBUTTON_PRESSED_FONT: TColor = clWhite;
  CS_COMBOBOX_DROPDOWNBUTTON_PRESSED_BACKGROUND: TColor = clBlack;

  //SPIN
  CS_SPIN_NORMAL: TColor = clBtnFace;
  CS_SPIN_NORMAL_FRAME: TColor = $E2E2E2;
  CS_SPIN_HOT: TColor = $EDEDED;
  CS_SPIN_HOT_FRAME: TColor = clBlack;
  CS_SPIN_PRESSED: TColor = $DEDEDE;
  CS_SPIN_PRESSED_FRAME: TColor = $E2E2E2;
  CS_SPIN_DISABLED: TColor = clGray;
  CS_SPIN_DISABLED_FRAME: TColor = $E2E2E2;
  CS_SPIN_ARROW: TColor = clBlack;

  //TOOLBAR
  CS_TOOLBAR_FONT: TCOLOR = clBlack;
  CS_TOOLBAR_BACKGROUND: TCOLOR = clForm;
  CS_TOOLBAR_BACKGROUND2: TCOLOR = clForm;
  CS_TOOLBAR_SEPARATOR: TCOLOR = $E2E2E2;
  CS_TOOLBAR_DROPDOWN_ARROW: TCOLOR = clBlack;
  CS_TOOLBAR_BUTTON_NORMAL: TCOLOR = clBtnFace;
  CS_TOOLBAR_BUTTON_NORMAL_FRAME: TCOLOR = clBtnShadow;
  CS_TOOLBAR_BUTTON_PRESSED: TCOLOR = $EDEDED;
  CS_TOOLBAR_BUTTON_PRESSED_FRAME: TCOLOR = clBtnShadow;
  CS_TOOLBAR_BUTTON_HOT: TCOLOR = $E0E0E0;     //Default on non Flat ToolBar
  CS_TOOLBAR_BUTTON_HOT_FRAME: TCOLOR = clBtnShadow;
  CS_TOOLBAR_BUTTON_DISABLED: TCOLOR = clGray;
  CS_TOOLBAR_BUTTON_DISABLED_FRAME: TCOLOR = clBtnShadow;
  CS_TOOLBAR_BUTTON_CHECKED: TCOLOR = $EDEDED;
  CS_TOOLBAR_BUTTON_CHECKED_FRAME: TCOLOR = clBtnShadow;
  CS_TOOLBAR_BUTTON_NEARHOT: TCOLOR = $00404040;
  CS_TOOLBAR_BUTTON_NEARHOT_FRAME: TCOLOR = clBtnShadow;
  CS_TOOLBAR_BUTTON_HOTCHECKED: TCOLOR = $00505050;
  CS_TOOLBAR_BUTTON_HOTCHECKED_FRAME: TCOLOR = clBtnShadow;
  CS_TOOLBAR_BUTTON_OTHERSIDEHOT: TCOLOR = $00353535;
  CS_TOOLBAR_BUTTON_OTHERSIDEHOT_FRAME: TCOLOR = clBtnShadow;

  //SCROLL
  CS_SCROLL_BACKGROUND: TColor = clWindow;
  CS_SCROLL_ARROW_NORMAL: TColor = clblack;
  CS_SCROLL_ARROW_HOT: TColor = clGray;
  CS_SCROLL_ARROW_DISABLED: TColor = clGray;
  CS_SCROLL_ARROW_BACKGROUND: TColor = clWindow;
  CS_SCROLL_GRIP_NORMAL: TColor = $E2E2E2;
  CS_SCROLL_GRIP_HOT: TColor = $F2F2F2;
  CS_SCROLL_GRIP_DISABLED: TColor = clGray;
  CS_SCROLL_GRIP_NORMAL_FRAME: TColor = $E2E2E2;
  CS_SCROLL_GRIP_HOT_FRAME: TColor = $F2F2F2;
  CS_SCROLL_GRIP_DISABLED_FRAME: TColor = clGray;

  //TAB
  CS_TAB_FONT: TCOLOR = clBlack;
  CS_TAB_PANE_BACKGROUND: TColor = clForm;
  CS_TAB_PANE_BORDER: TColor = $E2E2E2;
  CS_TAB_ITEM_HOT_BACKGROUND: TColor = $D0D0D0;
  CS_TAB_ITEM_HOT_FRAME: TColor = $E2E2E2;
  CS_TAB_ITEM_NORMAL_BACKGROUND: TColor = clBtnFace;
  CS_TAB_ITEM_NORMAL_FRAME: TColor = $E2E2E2;
  CS_TAB_ITEM_SELECTED_BACKGROUND: TColor = $DEDEDE;
  CS_TAB_ITEM_SELECTED_FRAME: TColor = $E2E2E2;
  CS_TAB_ITEM_DISABLED_BACKGROUND: TColor = clGray;
  CS_TAB_ITEM_DISABLED_FRAME: TColor = $E2E2E2;
  CS_TAB_ITEM_FOCUSED_BACKGROUND: TColor = clHighlight;
  CS_TAB_ITEM_FOCUSED_FRAME: TColor = $E2E2E2;

  //Menus
  CS_MENU_FONT: TColor = clBlack;                             // Menu Font Color
  CS_MENU_BACKGROUND: TColor = clMenuBar;                     // MainMenu Gradient 1
  CS_MENU_BACKGROUND2: TColor = clMenuBar;                    // MainMenu Gradient 2
  CS_MENU_ITEM_NORMAL: TColor = clMenuBar;
  // Main Menu Item Gradient 1
  CS_MENU_ITEM_NORMAL2: TColor = clMenuBar;
  // Main Menu Item Gradient 2
  CS_MENU_ITEM_HOT: TColor = clBtnFace;
  CS_MENU_ITEM_HOT2: TColor = clBtnFace;
  CS_MENU_ITEM_PUSHED: TColor = clHighlight;
  CS_MENU_ITEM_PUSHED2: TColor = clHighlight;
  CS_MENU_ITEM_DISABLED: TColor = clBtnFace;
  CS_MENU_ITEM_DISABLED2: TColor = clBtnFace;
  CS_MENU_ITEM_DISABLED_FONT: TColor = clGray;
  CS_POPUPMENU_FONT: TColor = clBlack;
  CS_POPUPMENU_BACKGROUND: TColor = clMenu;
  CS_POPUPMENU_BORDER: TColor = $E2E2E2;
  CS_POPUPMENU_ITEM_NORMAL: TColor = clMenu;
  CS_POPUPMENU_ITEM_HOT: TColor = clHighlight;
  CS_POPUPMENU_ITEM_DISABLED: TColor = clGray;
  CS_POPUPMENU_GUTTER: TColor = clgray;
  CS_POPUPMENU_SEPARATOR: TColor = clgray;
  CS_POPUPMENU_POPUPCHECK: TColor = clBlack;
  CS_POPUPMENU_POPUPCHECK_FRAME: TColor = clMenu;
  CS_POPUPMENU_POPUPCHECK_BACKGROUND: TColor = clMenu;
  CS_POPUPMENU_POPUPSUBMENU: TColor = clBlack;


function CS_DrawThemeBackground(hTheme: THandle; hdc: HDC;
  iPartId, iStateId: integer; const pRect: TRect; pClipRect: pRect): HRESULT; stdcall;


function CS_DrawThemeText(hTheme: HTHEME; hdc: HDC; iPartId, iStateId: integer;
  pszText: LPCWSTR; iCharCount: integer; dwTextFlags, dwTextFlags2: DWORD;
  const pRect: TRect): HRESULT;

implementation

uses
  SGJ.Win32Styles;

const
  MDL_SCROLLBOX_BTNLEFT = #$EE#$B7#$99; // $E00E
  MDL_SCROLLBOX_BTNRIGHT = #$EE#$B7#$9A; // $E00F
  MDL_SCROLLBOX_BTNUP = #$EE#$B7#$9B; // $E010
  MDL_SCROLLBOX_BTNDOWN = #$EE#$B7#$9C; // $E011
function GetThemeName():string;
var
  ThemeFile, ColorScheme, SizeName, DisplayName: array[0..MAX_PATH] of WideChar;
begin
  GetCurrentThemeName(
        ThemeFile, Length(ThemeFile),
        ColorScheme, Length(ColorScheme),
        SizeName, Length(SizeName)
      );
  GetThemeDocumentationProperty(
        ThemeFile, 'DisplayName', DisplayName, Length(DisplayName)
      );

  result:= DisplayName;
end;

function Button_DrawThemeBackground(hTheme: THandle; hdc: HDC;
  iPartId, iStateId: integer; const pRect: TRect; pClipRect: pRect): HRESULT;
var
  LCanvas: TCanvas;
  b: TBGRABitmap;
begin
  LCanvas := TCanvas.Create;
  try
    LCanvas.Handle := HDC;
    LCanvas.Brush.Style := bsClear;

    if iStateId in [PBS_NORMAL, PBS_DEFAULTED, PBS_DEFAULTED_ANIMATING] then
    begin
      LCanvas.Brush.Color := CS_BUTTON_PUSHBUTTON_NORMAL;
      LCanvas.Pen.Color := CS_BUTTON_PUSHBUTTON_FRAME_NORMAL;
    end
    else if iStateId in [PBS_HOT] then
    begin
      LCanvas.Brush.Color := CS_BUTTON_PUSHBUTTON_HOT;
      LCanvas.Pen.Color := CS_BUTTON_PUSHBUTTON_FRAME_HOT;
    end
    else if iStateId in [PBS_PRESSED] then
    begin
      LCanvas.Brush.Color := CS_BUTTON_PUSHBUTTON_PRESSED;
      LCanvas.Pen.Color := CS_BUTTON_PUSHBUTTON_FRAME_PRESSED;
    end
    else if iStateId in [PBS_DEFAULTED] then
    begin
      LCanvas.Brush.Color := CS_BUTTON_PUSHBUTTON_DEFAULTED;
      LCanvas.Pen.Color := CS_BUTTON_PUSHBUTTON_FRAME_DEFAULTED;
    end
    else if iStateId in [PBS_DISABLED] then
    begin
      LCanvas.Brush.Color := CS_BUTTON_PUSHBUTTON_DISABLED;
      LCanvas.Pen.Color := CS_BUTTON_PUSHBUTTON_FRAME_DISABLED;
    end
    else
    begin
      LCanvas.Brush.Color := CS_BUTTON_PUSHBUTTON_NORMAL;
      LCanvas.Pen.Color := CS_BUTTON_PUSHBUTTON_FRAME_NORMAL;
    end;
    if (GetThemeName='Zune Style     ') or
    (GetthemeName='Embedded Style ') then
    begin
      LCanvas.FillRect(Prect);
      LCanvas.Rectangle(PRect);
    end
    else begin
    b := TBGRABitmap.Create(pRect.Width, pRect.Height);
    b.FillRoundRectAntialias(pRect.left, pRect.Top, pRect.Width -
      1, prect.Height - 1, 4, 4, LCanvas.Brush.Color, [], True);
    b.RoundRectAntialias(pRect.left, pRect.Top, pRect.Width - 1,
      prect.Height - 1, 4, 4, LCanvas.Pen.Color, 1, []);
    b.draw(LCanvas, 0, 0, False);
    b.Free;
    end;
  finally
    LCanvas.Handle := 0;
    LCanvas.Free;

  end;
end;

procedure DrawRadionButton(hTheme: HTHEME; hdc: HDC; iPartId, iStateId: integer;
  const pRect: TRect; pClipRect: pRECT);
var
  LCanvas: TCanvas;
  AStyle: TTextStyle;
const
  MDL_RADIO_FILLED = #$EE#$A8#$BB; // $EA3B
  MDL_RADIO_CHECKED = #$EE#$A4#$95; // $E915
  MDL_RADIO_OUTLINE = #$EE#$A8#$BA; // $EA3A
begin
  LCanvas := TCanvas.Create;
  try
    LCanvas.Handle := hdc;

    // LCanvas.Brush.Color:= CS_clBtnFace;
    // LCanvas.FillRect(pRect);

    AStyle := LCanvas.TextStyle;
    AStyle.Layout := tlCenter;
    AStyle.ShowPrefix := True;

    // Draw radio circle
    LCanvas.Font.Name := 'Segoe MDL2 Assets';
    if iStateId in [RBS_CHECKEDNORMAL, RBS_CHECKEDHOT, RBS_CHECKEDPRESSED] then
      LCanvas.Font.Color := CS_BUTTON_RADIOBUTTON_CHECKED
    else
    if iStateId in [RBS_CHECKEDDISABLED] then
      LCanvas.Font.Color := CS_BUTTON_RADIOBUTTON_DISABLED
    else
      LCanvas.Font.Color := CS_BUTTON_RADIOBUTTON;
    LCanvas.TextRect(pRect, pRect.TopLeft.X, pRect.TopLeft.Y, MDL_RADIO_FILLED, AStyle);

    // Draw radio button state
    if iStateId in [RBS_CHECKEDNORMAL, RBS_CHECKEDHOT, RBS_CHECKEDPRESSED,
      RBS_CHECKEDDISABLED] then
    begin
      LCanvas.Font.Color := CS_BUTTON_RADIOBUTTON_State;
      LCanvas.TextRect(pRect, pRect.TopLeft.X, pRect.TopLeft.Y,
        MDL_RADIO_CHECKED, AStyle);
    end;

    // Set outline circle color
    if iStateId in [RBS_UNCHECKEDPRESSED, RBS_CHECKEDPRESSED] then
      LCanvas.Font.Color := CS_BUTTON_RADIOBUTTON_Border_Pressed
    else if iStateId in [RBS_UNCHECKEDHOT, RBS_CHECKEDHOT] then
      LCanvas.Font.Color := CS_BUTTON_RADIOBUTTON_Border_HOT
    else if iStateId in [RBS_UNCHECKEDDISABLED, RBS_CHECKEDDISABLED] then
      LCanvas.Font.Color := CS_BUTTON_RADIOBUTTON_Border_DISABLED
    else
    begin
      LCanvas.Font.Color := CS_BUTTON_RADIOBUTTON_Border;
    end;
    // Draw outline circle
    LCanvas.TextRect(pRect, pRect.TopLeft.X, pRect.TopLeft.Y, MDL_RADIO_OUTLINE, AStyle);
  finally
    LCanvas.Handle := 0;
    LCanvas.Free;
  end;
end;

procedure DrawCheckBox(hTheme: HTHEME; hdc: HDC; iPartId, iStateId: integer;
  const pRect: TRect; pClipRect: pRECT);
var
  LCanvas: TCanvas;
  AStyle: TTextStyle;
const
  MDL_CHECKBOX_FILLED = #$EE#$9C#$BB; // $E73B
  MDL_CHECKBOX_CHECKED = #$EE#$9C#$BE; // $E73E
  MDL_CHECKBOX_GRAYED = #$EE#$9C#$BC; // $E73C
  MDL_CHECKBOX_OUTLINE = #$EE#$9C#$B9; // $E739
begin
  LCanvas := TCanvas.Create;
  try
    LCanvas.Handle := HDC;

    AStyle := LCanvas.TextStyle;
    AStyle.Layout := tlCenter;
    AStyle.ShowPrefix := True;

    // Fill checkbox rect
    LCanvas.Font.Name := 'Segoe MDL2 Assets';
    if iStateId in [CBS_CHECKEDDISABLED,
      CBS_MIXEDDISABLED, CBS_IMPLICITDISABLED, CBS_EXCLUDEDDISABLED] then
      LCanvas.Font.Color := CS_BUTTON_CHECKBOX_DISABLED
    else
      LCanvas.Font.Color := CS_BUTTON_CHECKBOX;
    LCanvas.TextRect(pRect, pRect.TopLeft.X, pRect.TopLeft.Y,
      MDL_CHECKBOX_FILLED, AStyle);

    // Draw checkbox border
    if iStateId in [CBS_UNCHECKEDHOT, CBS_MIXEDHOT, CBS_CHECKEDHOT] then
      LCanvas.Font.Color := CS_BUTTON_CHECKBOX_Border_HOT
    else
    if iStateId in [CBS_UNCHECKEDDISABLED, CBS_CHECKEDDISABLED,
      CBS_MIXEDDISABLED, CBS_IMPLICITDISABLED, CBS_EXCLUDEDDISABLED] then
      LCanvas.Font.Color := CS_BUTTON_CHECKBOX_Border_DISABLED
    else
    begin
      LCanvas.Font.Color := CS_BUTTON_CHECKBOX_Border;
    end;
    LCanvas.TextRect(pRect, pRect.TopLeft.X, pRect.TopLeft.Y,
      MDL_CHECKBOX_OUTLINE, AStyle);

    // Draw checkbox state
    if iStateId in [CBS_MIXEDNORMAL, CBS_MIXEDHOT, CBS_MIXEDPRESSED,
      CBS_MIXEDDISABLED] then
    begin
      LCanvas.Font.Color := CS_BUTTON_CHECKBOX_State;
      LCanvas.TextRect(pRect, pRect.TopLeft.X, pRect.TopLeft.Y,
        MDL_CHECKBOX_GRAYED, AStyle);
    end
    else if iStateId in [CBS_CHECKEDNORMAL, CBS_CHECKEDHOT,
      CBS_CHECKEDPRESSED, CBS_CHECKEDDISABLED] then
    begin
      if iStateID = CBS_CHECKEDDISABLED then
        LCanvas.Font.Color := CS_BUTTON_CHECKBOX_State_DISABLED
      else
        LCanvas.Font.Color := CS_BUTTON_CHECKBOX_State;
      LCanvas.TextRect(pRect, pRect.TopLeft.X, pRect.TopLeft.Y,
        MDL_CHECKBOX_CHECKED, AStyle);
    end;
  finally
    LCanvas.Handle := 0;
    LCanvas.Free;
  end;
end;

procedure DrawEdit(hTheme: HTHEME; hdc: HDC; iPartId, iStateId: integer;
  const pRect: TRect; pClipRect: pRECT);
var
  LCanvas: TCanvas;
begin
  LCanvas := TCanvas.Create;
  try
    LCanvas.Handle := HDC;

    case iPartID of
      EP_BACKGROUND,
      EP_BACKGROUNDWITHBORDER: begin
        LCanvas.pen.Color := CS_EDIT_INNER_BORDER;
        //CS_EDIT_INNER_BORDER
        case iStateId of
          EBS_NORMAL: LCanvas.Brush.Color := CS_EDIT_INNER_BACKGROUND_NORMAL;
          //CS_EDIT_INNER_BACKGROUND_NORMAL
          EBS_HOT: LCanvas.Brush.Color := CS_EDIT_INNER_BACKGROUND_HOT;
          //CS_EDIT_INNER_BACKGROUND_HOT
          EBS_DISABLED: LCanvas.Brush.Color :=
              CS_EDIT_INNER_BACKGROUND_DISABLED;    //CS_EDIT_INNER_BACKGROUND_DISABLED
          EBS_FOCUSED: LCanvas.Brush.Color :=
              CS_EDIT_INNER_BACKGROUND_FOCUSED;
          //CS_EDIT_INNER_BACKGROUND_FOCUSED
          EBS_READONLY: LCanvas.Brush.Color :=
              CS_EDIT_INNER_BACKGROUND_READONLY;   //CS_EDIT_INNER_BACKGROUND_READONLY
          EBS_ASSIST: LCanvas.Brush.Color := CS_EDIT_INNER_BACKGROUND_ASSIST;
          //CS_EDIT_INNER_BACKGROUND_ASSIST
        end;
      end;
      EP_EDITBORDER_NOSCROLL,
      EP_EDITBORDER_HSCROLL,
      EP_EDITBORDER_VSCROLL,
      EP_EDITBORDER_HVSCROLL: begin
        LCanvas.Brush.Color := CS_EDIT_OUTER_BACKGROUND;
        //CS_EDIT_OUTER_BACKGROUND
        LCanvas.pen.Color := CS_EDIT_OUTER_BORDER;
        //CS_EDIT_OUTER_BORDER
      end;
    end;
    // LCanvas.FillRect(pRect);
    LCanvas.RoundRect(pRect, 0, 0);
  finally
    LCanvas.Handle := 0;
    LCanvas.Free;
  end;
end;

procedure DrawGroupBox(hTheme: HTHEME; hdc: HDC; iPartId, iStateId: integer;
  const pRect: TRect; pClipRect: pRECT);
var
  LCanvas: TCanvas;
  b: TBGRABitmap;
begin
  LCanvas := TCanvas.Create;
  try
    LCanvas.Handle := HDC;

    // Draw border
    LCanvas.Brush.Style := bsClear;
    LCanvas.Pen.Color := CS_BUTTON_GROUPBOX_Border;

    b := TBGRABitmap.Create(pRect.Width, pRect.Height);
    b.RoundRectAntialias(pRect.left, pRect.Top, pRect.Width - 1, prect.Height - 1,
      10, 10, LCanvas.Pen.Color, 1, []);
    b.draw(LCanvas, 0, 0, False);
    b.Free;
  finally
    LCanvas.Handle := 0;
    LCanvas.Free;
  end;
end;

function ComboBox_DrawThemeBackground(hTheme: THandle; hdc: HDC;
  iPartId, iStateId: integer; const pRect: TRect; pClipRect: pRect): HRESULT;
const
  MDL_COMBOBOX_BTNDOWN = #$EE#$A5#$B2; // $E972
var
  LCanvas: TCanvas;
  AStyle: TTextStyle;
  BtnSym: string;
  r: TRect;
begin
  LCanvas := TCanvas.Create;

  LCanvas.Handle := HDC;
  case iPartId of
    CP_BORDER: begin
      LCanvas.Brush.Color := CS_COMBOBOX_Normal;
      LCanvas.FillRect(pRect);

      if iStateId in [CBXS_DISABLED] then
        LCanvas.Brush.Color := CS_COMBOBOX_Frame_Disabled
      else if iStateId in [CBXS_HOT] then
        LCanvas.Brush.Color := CS_COMBOBOX_Frame_Hot
      else
        LCanvas.Brush.Color := CS_COMBOBOX_Frame;
      LCanvas.FrameRect(pRect);
    end;

    CP_READONLY: begin
      if iStateId in [CBRO_DISABLED] then
      begin
        LCanvas.Brush.Color := CS_COMBOBOX_READONLY_Disabled;
        LCanvas.Pen.Color := CS_COMBOBOX_READONLY_DISABLED_FRAME;
      end
      else
      if iStateId in [CBRO_NORMAL] then
      begin
        LCanvas.Brush.Color := CS_COMBOBOX_READONLY_Normal;
        LCanvas.Pen.Color := CS_COMBOBOX_READONLY_Frame;
      end
      else if iStateId in [CBRO_HOT] then
      begin
        LCanvas.Brush.Color := CS_COMBOBOX_READONLY_Hot;
        LCanvas.Pen.Color := CS_COMBOBOX_READONLY_HOT_FRAME;
      end
      else if iStateId in [CBRO_PRESSED] then
      begin
        LCanvas.Brush.Color := CS_COMBOBOX_READONLY_Pressed;
        LCanvas.Pen.Color := CS_COMBOBOX_READONLY_PRESSED_FRAME;
      end
      else
      begin
        LCanvas.Brush.Color := CS_COMBOBOX_READONLY_Normal;
        LCanvas.Pen.Color := CS_COMBOBOX_READONLY_Frame;
      end;
      LCanvas.FillRect(pRect);

      LCanvas.Frame(pRect);
    end;


    CP_DROPDOWNBUTTON, CP_DROPDOWNBUTTONRIGHT, CP_DROPDOWNBUTTONLEFT: begin

      AStyle := LCanvas.TextStyle;
      AStyle.Alignment := taCenter;
      AStyle.Layout := tlCenter;
      AStyle.ShowPrefix := True;
      LCanvas.Font.Name := 'Segoe MDL2 Assets';
      LCanvas.Font.Size := 6;
      BtnSym := MDL_COMBOBOX_BTNDOWN;

      if Win32MajorVersion=5 then begin
      if iStateId in [CBXS_Normal] then
      begin
        LCanvas.Font.Color := clWhite;
        LCanvas.Brush.Color := CS_COMBOBOX_Normal;
        LCanvas.FillRect(prect);
      end;
      end;
      if iStateId in [CBXS_DISABLED] then
      begin
        LCanvas.Font.Color := CS_COMBOBOX_DROPDOWNBUTTON_DISABLED_FONT;
        LCanvas.Brush.Color := CS_COMBOBOX_DROPDOWNBUTTON_DISABLED_BACKGROUND;
        LCanvas.FillRect(prect);
      end
      else if iStateId in [CBXS_HOT] then
      begin
        LCanvas.Font.Color := CS_COMBOBOX_DROPDOWNBUTTON_HOT_FONT;
        LCanvas.Brush.Color := CS_COMBOBOX_DROPDOWNBUTTON_HOT_BACKGROUND;
        LCanvas.FillRect(prect);
      end
      else if iStateId in [CBXS_PRESSED] then
      begin
        LCanvas.Font.Color := CS_COMBOBOX_DROPDOWNBUTTON_PRESSED_FONT;
        LCanvas.Brush.Color := CS_COMBOBOX_DROPDOWNBUTTON_PRESSED_BACKGROUND;
        LCanvas.FillRect(prect);
      end
      else
      begin
        //Empty for readonly compatibility
        //LCanvas.Font.Color := clWhite;
        //LCanvas.Brush.Color := clred;
        //LCanvas.FillRect(prect);
      end;
      r := pRect;
      InflateRect(r, -1, -1);
      // LCanvas.FillRect(r);
      LCanvas.TextRect(r, pRect.TopLeft.X, pRect.TopLeft.Y, BtnSym, AStyle);
    end;

  end;
  LCanvas.Free;
end;

function Header_DrawThemeBackground(hTheme: THandle; hdc: HDC;
  iPartId, iStateId: integer; const pRect: TRect; pClipRect: pRect): HRESULT;
var
  LCanvas: TCanvas;
begin
  if (iPartId = 0) then
  begin   // The unpainted area of the header after the rightmost column
    LCanvas := TCanvas.Create;
    try
      LCanvas.Handle := hdc;
      LCanvas.GradientFill(pRect, CS_HEADER_ITEM_NORMAL, CS_HEADER_ITEM_NORMAL2,
        gdVertical);
      LCanvas.Pen.Color := CS_HEADER_BORDER_BOTTOM;
      LCanvas.Line(pRect.Left, pRect.Bottom - 1, pRect.Right, pRect.Bottom - 1);
    finally
      LCanvas.Handle := 0;
      LCanvas.Free;
    end;
  end;

  if iPartId in [HP_HEADERITEM, HP_HEADERITEMRIGHT] then
  begin
    LCanvas := TCanvas.Create;
    try
      LCanvas.Handle := hdc;
      if iStateId in [HIS_HOT, HIS_SORTEDHOT, HIS_ICONHOT, HIS_ICONSORTEDHOT] then
      begin
        LCanvas.GradientFill(pRect, CS_HEADER_ITEM_HOT, CS_HEADER_ITEM_HOT2, gdVertical);
      end
      else if iStateId in [HIS_PRESSED] then
      begin
        LCanvas.GradientFill(pRect, CS_HEADER_ITEM_PRESSED,
          CS_HEADER_ITEM_PRESSED2, gdVertical);
      end
      else
      begin
        LCanvas.GradientFill(pRect, CS_HEADER_ITEM_NORMAL, CS_HEADER_ITEM_NORMAL2,
          gdVertical);
      end;


      if (iPartId <> HP_HEADERITEMRIGHT) then
      begin

        LCanvas.Pen.Color := CS_HEADER_BORDER_RIGHT;
        LCanvas.Line(pRect.Right - 1, pRect.Top, pRect.Right - 1, pRect.Bottom);

        LCanvas.Pen.Color := CS_HEADER_BORDER_RIGHT;
        LCanvas.Line(pRect.Right - 2, pRect.Top, pRect.Right - 2, pRect.Bottom);
      end;
      // Top line
      LCanvas.Pen.Color := CS_HEADER_BORDER_TOP;
      LCanvas.Line(pRect.Left, pRect.Top, pRect.Right, pRect.Top);
      // Bottom line
      LCanvas.Pen.Color := CS_HEADER_BORDER_BOTTOM;
      LCanvas.Line(pRect.Left, pRect.Bottom - 1, pRect.Right, pRect.Bottom - 1);
    finally
      LCanvas.Handle := 0;
      LCanvas.Free;
    end;
  end;
end;

function ListView_DrawThemeBackground(hTheme: THandle; hdc: HDC;
  iPartId, iStateId: integer; const pRect: TRect; pClipRect: pRect): HRESULT;
var
  LCanvas: TCanvas;
  b: TBGRABitmap;
begin
  if (iPartId = LVP_LISTITEM) then
  begin
    if (iStateId in [LISS_SELECTED, LISS_HOTSELECTED]) then
    begin
      LCanvas := TCanvas.Create;
      LCanvas.Handle := hdc;

      b := TBGRABitmap.Create(pRect.Width, pRect.Height);
      b.FillRoundRectAntialias(0, 0, pRect.Width - 1, pRect.Height - 1,
        4, 4, CS_LISTVIEW_ITEM_SELECTED, [], True);

      b.RoundRectAntialias(0, 0, pRect.Width - 1,
        prect.Height - 1, 4, 4, CS_LISTVIEW_ITEM_SELECTED_BORDER, 1, []);
      b.draw(LCanvas, pRect.left, pRect.Top, False);
      b.Free;
      LCanvas.Handle := 0;
      LCanvas.Free;

    end;
    if (iStateId in [LISS_HOT]) then
    begin
      LCanvas := TCanvas.Create;
      LCanvas.Handle := hdc;
      b := TBGRABitmap.Create(pRect.Width, pRect.Height);
      b.FillRoundRectAntialias(0, 0, pRect.Width - 1,
        prect.Height - 1, 4, 4, CS_LISTVIEW_ITEM_HOT, [], True);
      b.RoundRectAntialias(0, 0, pRect.Width - 1,
        prect.Height - 1, 4, 4, CS_LISTVIEW_ITEM_HOT_BORDER, 1, []);
      b.draw(LCanvas, pRect.left, pRect.Top, False);
      b.Free;

      LCanvas.Handle := 0;
      LCanvas.Free;

    end;

  end;
end;

function TreeView_DrawThemeBackground(hTheme: THandle; hdc: HDC;
  iPartId, iStateId: integer; const pRect: TRect; pClipRect: pRect): HRESULT;
var
  LCanvas: TCanvas;
  b: TBGRABitmap;
begin
  if (iPartId = TVP_TREEITEM) then
  begin
    if (iStateId in [TREIS_SELECTED, TREIS_HOTSELECTED]) then
    begin
      LCanvas := TCanvas.Create;
      LCanvas.Handle := hdc;
      b := TBGRABitmap.Create(pRect.Width, pRect.Height);
      b.FillRoundRectAntialias(0, 0, pRect.Width - 1, pRect.Height - 1,
        4, 4, CS_TREEVIEW_ITEM_SELECTED, [], True);

      b.RoundRectAntialias(0, 0, pRect.Width - 1,
        prect.Height - 1, 4, 4, CS_TREEVIEW_ITEM_SELECTED_BORDER, 1, []);
      b.draw(LCanvas, pRect.left, pRect.Top, False);
      b.Free;
      LCanvas.Handle := 0;
      LCanvas.Free;
    end;
    if (iStateId in [TREIS_HOT]) then
    begin
      LCanvas := TCanvas.Create;
      LCanvas.Handle := hdc;
      b := TBGRABitmap.Create(pRect.Width, pRect.Height);
      b.FillRoundRectAntialias(0, 0, pRect.Width - 1, pRect.Height - 1,
        4, 4, CS_TREEVIEW_ITEM_HOT, [], True);

      b.RoundRectAntialias(0, 0, pRect.Width - 1,
        prect.Height - 1, 4, 4, CS_TREEVIEW_ITEM_HOT_BORDER, 1, []);
      b.draw(LCanvas, pRect.left, pRect.Top, False);
      b.Free;

      LCanvas.Handle := 0;
      LCanvas.Free;
    end;
  end;

end;

function Menu_DrawThemeBackground(hTheme: THandle; hdc: HDC;
  iPartId, iStateId: integer; const pRect: TRect; pClipRect: pRect): HRESULT;
var
  LCanvas: TCanvas;
  LRect: TRECT;
  AStyle: TTextStyle;
const
  MDL_CHECKBOX_CHECKED = #$EE#$9C#$BE; // $E73E
  MDL_MENU_SUBMENU = #$EE#$A5#$B0; // $E970
begin
  LCanvas := TCanvas.Create;
  LCanvas.Handle := hdc;
  try
    case iPartId of

      MENU_POPUPBACKGROUND: begin
        //LCanvas.Brush.Color := CS_POPUPMENU_Background;
        //LCanvas.FillRect(prect);
      end;
      MENU_POPUPGUTTER: begin
        LCanvas.Brush.Color := CS_POPUPMENU_GUTTER;
        LCanvas.FillRect(prect);
      end;
      MENU_POPUPSEPARATOR: begin

        LCanvas.Brush.Color := CS_POPUPMENU_Background;
        LRect := prect;
        inflaterect(LRect, 1, 1);
        LCanvas.FillRect(LRect);

        LRect := pRect;
        LCanvas.Pen.Color := CS_POPUPMENU_SEPARATOR;
        LRect.Top := LRect.Top + (LRect.Height div 2);
        LRect.Bottom := LRect.Top;
        LCanvas.Line(LRect);
      end;
      MENU_BARBACKGROUND: begin
        LCanvas.GradientFill(pRect, CS_MENU_BACKGROUND, CS_MENU_BACKGROUND2, gdVertical);
      end;

      MENU_BARITEM: begin
        case iStateId of
          MBI_NORMAL: begin
            LCanvas.GradientFill(pRect, CS_MENU_ITEM_NORMAL,
              CS_MENU_ITEM_NORMAL2, gdVertical);
          end;
          MBI_HOT: begin
            LCanvas.GradientFill(pRect, CS_MENU_ITEM_HOT, CS_MENU_ITEM_HOT, gdVertical);
          end;
          MBI_PUSHED: begin
            LCanvas.GradientFill(pRect, CS_MENU_ITEM_PUSHED,
              CS_MENU_ITEM_PUSHED2, gdVertical);
          end;
          MBI_DISABLED,
          MBI_DISABLEDHOT,
          MBI_DISABLEDPUSHED: begin
            LCanvas.GradientFill(pRect, CS_MENU_ITEM_DISABLED,
              CS_MENU_ITEM_DISABLED2, gdVertical);
          end;

        end;
      end;
      MENU_POPUPITEM: case iStateID of
          MPI_NORMAL: begin
            LCanvas.Brush.Color := CS_POPUPMENU_ITEM_NORMAL;
            LCanvas.FillRect(prect);
          end;
          MPI_HOT: begin
            LCanvas.Brush.Color := CS_POPUPMENU_ITEM_HOT;
            LCanvas.FillRect(prect);
          end;
          MPI_DISABLED,
          MPI_DISABLEDHOT: begin
            LCanvas.Brush.Color := CS_POPUPMENU_ITEM_DISABLED;
            LCanvas.FillRect(prect);
          end;
        end;
      MENU_POPUPCHECK:
      begin
        AStyle := LCanvas.TextStyle;
        AStyle.Layout := tlCenter;
        AStyle.Alignment := taCenter;
        LCanvas.Brush.Style := bsClear;
        LCanvas.Font.Name := 'Segoe MDL2 Assets';
        LCanvas.Font.Color := CS_POPUPMENU_POPUPCHECK;
        LCanvas.TextRect(pRect, pRect.TopLeft.X, pRect.TopLeft.Y,
          MDL_CHECKBOX_CHECKED, AStyle);
      end;
      MENU_POPUPCHECKBACKGROUND: begin
        LRect := pRect;
        InflateRect(LRect, -1, -1);
        LCanvas.Pen.Color := CS_POPUPMENU_POPUPCHECK_FRAME;
        LCanvas.Brush.Color := CS_POPUPMENU_POPUPCHECK_BACKGROUND;
        LCanvas.RoundRect(LRect, 6, 6);
      end;

      MENU_POPUPSUBMENU: begin
        LCanvas.Brush.Style := bsClear;
        LCanvas.Font.Name := 'Segoe MDL2 Assets';
        LCanvas.Font.Size := 6;
        LCanvas.Font.Color := CS_POPUPMENU_POPUPCHECK;
        LCanvas.TextOut(pRect.Left, pRect.Top, MDL_MENU_SUBMENU);
      end;
      else
        Result := WinDrawThemeBackground(hTheme, hdc, iPartId,
          iStateId, pRect, pClipRect);
    end;
  finally
    LCanvas.Handle := 0;
    LCanvas.Free;
  end;
end;

procedure DrawScrollBar(hTheme: HTHEME; hdc: HDC; iPartId, iStateId: integer;
  const pRect: TRect; pClipRect: pRECT);
var
  LCanvas: TCanvas;
  AStyle: TTextStyle;
  BtnSym: string;
  b: TBGRABitmap;
begin
  LCanvas := TCanvas.Create;
  try
    LCanvas.Handle := HDC;

    case iPartId of
      SBP_ARROWBTN: begin
        LCanvas.Brush.Color := CS_SCROLL_ARROW_BACKGROUND;
        LCanvas.FillRect(pRect);

        AStyle := LCanvas.TextStyle;
        AStyle.Alignment := taCenter;
        AStyle.Layout := tlCenter;
        AStyle.ShowPrefix := True;
        LCanvas.Font.Size := 6;
        LCanvas.Font.Name := 'Segoe MDL2 Assets';
        case iStateId of
          ABS_UPNORMAL,
          ABS_UPHOT,
          ABS_UPPRESSED,
          ABS_UPDISABLED: BtnSym := MDL_SCROLLBOX_BTNUP;
          ABS_DOWNNORMAL,
          ABS_DOWNHOT,
          ABS_DOWNPRESSED,
          ABS_DOWNDISABLED: BtnSym := MDL_SCROLLBOX_BTNDOWN;
          ABS_LEFTNORMAL,
          ABS_LEFTHOT,
          ABS_LEFTPRESSED,
          ABS_LEFTDISABLED: BtnSym := MDL_SCROLLBOX_BTNLEFT;
          ABS_RIGHTNORMAL,
          ABS_RIGHTHOT,
          ABS_RIGHTPRESSED,
          ABS_RIGHTDISABLED: BtnSym := MDL_SCROLLBOX_BTNRIGHT;
          ABS_UPHOVER: BtnSym := MDL_SCROLLBOX_BTNUP;
          ABS_DOWNHOVER: BtnSym := MDL_SCROLLBOX_BTNDOWN;
          ABS_LEFTHOVER: BtnSym := MDL_SCROLLBOX_BTNLEFT;
          ABS_RIGHTHOVER: BtnSym := MDL_SCROLLBOX_BTNRIGHT;
        end;

        if iStateId in [ABS_UPDISABLED, ABS_DOWNDISABLED,
          ABS_LEFTDISABLED, ABS_RIGHTDISABLED] then
          LCanvas.Font.Color := CS_SCROLL_ARROW_DISABLED
        else if iStateId in [ABS_UPHOT, ABS_DOWNHOT, ABS_LEFTHOT,
          ABS_RIGHTHOT, ABS_UPPRESSED, ABS_DOWNPRESSED, ABS_LEFTPRESSED,
          ABS_RIGHTPRESSED] then
          LCanvas.Font.Color := CS_SCROLL_ARROW_HOT
        else
        begin
          LCanvas.Font.Color := CS_SCROLL_ARROW_NORMAL;
        end;
        LCanvas.TextRect(pRect, pRect.TopLeft.X, pRect.TopLeft.Y, BtnSym, AStyle);
      end;

      SBP_GRIPPERHORZ, SBP_GRIPPERVERT: begin
        if iStateId in [ABS_UPDISABLED, ABS_DOWNDISABLED,
          ABS_LEFTDISABLED, ABS_RIGHTDISABLED] then
        begin
          LCanvas.Brush.Color := CS_SCROLL_GRIP_DISABLED;
          LCanvas.Pen.Color := CS_SCROLL_GRIP_DISABLED_FRAME;
        end
        else if iStateId in [ABS_UPHOT, ABS_DOWNHOT, ABS_LEFTHOT,
          ABS_RIGHTHOT, ABS_UPPRESSED, ABS_DOWNPRESSED, ABS_LEFTPRESSED,
          ABS_RIGHTPRESSED] then
        begin
          LCanvas.Brush.Color := CS_SCROLL_GRIP_HOT;
          LCanvas.Pen.Color := CS_SCROLL_GRIP_HOT_FRAME;
        end
        else
        begin
          LCanvas.Brush.Color := CS_SCROLL_GRIP_NORMAL;
          LCanvas.Pen.Color := CS_SCROLL_GRIP_NORMAL_FRAME;
        end;
        b := TBGRABitmap.Create(pRect.Width, pRect.Height);

        b.FillRoundRectAntialias(0, 0, pRect.Width - 1,
          prect.Height - 1, 4, 4, LCanvas.Brush.Color, [], True);

        b.RoundRectAntialias(0, 0, pRect.Width - 1,
          prect.Height - 1, 4, 4, LCanvas.Pen.Color, 1, []);
        b.draw(LCanvas, prect.left, prect.top, False);
        b.Free;

      end;
      else
      begin
        LCanvas.Brush.Color := CS_SCROLL_BACKGROUND;
        LCanvas.Pen.Color := LCanvas.Brush.Color;
        LCanvas.FillRect(pRect);
      end;
    end;

  finally
    LCanvas.Handle := 0;
    LCanvas.Free;
  end;
end;

procedure DrawTAB(hTheme: HTHEME; hdc: HDC; iPartId, iStateId: integer;
  const pRect: TRect; pClipRect: pRECT);
var
  LCanvas: TCanvas;
begin
  LCanvas := TCanvas.Create;
  try
    LCanvas.Handle := HDC;

    case iPartId of
      TABP_BODY:begin
        LCanvas.Pen.Color := CS_TAB_PANE_BORDER;
        LCanvas.Brush.color := CS_TAB_PANE_BACKGROUND;
        LCanvas.FillRect(prect);
        LCanvas.Rectangle(prect);
      end;
      TABP_PANE: begin
        LCanvas.Pen.Color := CS_TAB_PANE_BORDER;
        LCanvas.Brush.color := CS_TAB_PANE_BACKGROUND;
        LCanvas.FillRect(prect);
        LCanvas.Rectangle(prect);
      end;
      TABP_TABITEM,
      TABP_TABITEMLEFTEDGE,
      TABP_TABITEMRIGHTEDGE,
      TABP_TABITEMBOTHEDGE,
      TABP_TOPTABITEM,
      TABP_TOPTABITEMLEFTEDGE,
      TABP_TOPTABITEMBOTHEDGE,
      TABP_TOPTABITEMRIGHTEDGE: begin
        case iStateID of
          1: begin
            LCanvas.Brush.color := CS_TAB_ITEM_NORMAL_BACKGROUND;
            LCanvas.Pen.color := CS_TAB_ITEM_NORMAL_FRAME;
          end;
          2: begin
            LCanvas.Brush.color := CS_TAB_ITEM_HOT_BACKGROUND;
            LCanvas.Pen.color := CS_TAB_ITEM_HOT_FRAME;
          end;
          3: begin
            LCanvas.Brush.color := CS_TAB_ITEM_SELECTED_BACKGROUND;
            LCanvas.Pen.color := CS_TAB_ITEM_SELECTED_FRAME;
          end;
          4: begin
            LCanvas.Brush.color := CS_TAB_ITEM_DISABLED_BACKGROUND;
            LCanvas.Pen.color := CS_TAB_ITEM_DISABLED_FRAME;
          end;
          5: begin
            LCanvas.Brush.color := CS_TAB_ITEM_FOCUSED_BACKGROUND;
            LCanvas.Pen.color := CS_TAB_ITEM_FOCUSED_FRAME;
          end;
        end;
        LCanvas.FillRect(prect);
        LCanvas.Frame(prect);
      end;
    end;
  finally
    LCanvas.Free;
  end;
end;

procedure DrawProgressBar(hTheme: HTHEME; hdc: HDC; iPartId, iStateId: integer;
  const pRect: TRect; pClipRect: pRECT);
var
  lCanvas: TCanvas;
  R:TRECT;
begin
  LCanvas := TCanvas.Create;
  LCanvas.Handle := hdc;
  case iPartId of
    PP_FILL, PP_FILLVERT: begin
      if CS_PROGRESS_Fill_1 <> clNone then
      begin
        R:=prect;
        inflaterect(R,-1,-1);
        if iPartId = PP_FILL then
          LCanvas.GradientFill(R, CS_PROGRESS_Fill_1, CS_PROGRESS_Fill_2, gdvertical);
        if iPartId = PP_FILLVERT then
          LCanvas.GradientFill(R, CS_PROGRESS_Fill_1, CS_PROGRESS_Fill_2, gdHorizontal);
      end
      else
        WinDrawThemeBackground(hTheme, hdc, iPartId, iStateId, pRect, pClipRect);
    end;
    PP_BAR, PP_BARVERT, PP_TRANSPARENTBAR, PP_TRANSPARENTBARVERT: begin
      LCanvas.Brush.Color := CS_PROGRESS_BACKGROUND;
      LCanvas.Pen.Color := CS_PROGRESS_FRAME;
      LCanvas.RoundRect(pRect, 0, 0);
    end;
    else
      WinDrawThemeBackground(hTheme, hdc, iPartId, iStateId, pRect, pClipRect);
  end;
  LCanvas.Handle := 0;
  LCanvas.Free;
end;

procedure DrawStatusBar(hTheme: HTHEME; hdc: HDC; iPartId, iStateId: integer;
  const pRect: TRect; pClipRect: pRECT);
var
  LCanvas: TCanvas;
  Detail: TThemedElementDetails;
  Rect: trect;
  gripSize: TSize;
begin
  LCanvas := TCanvas.Create;
  LCanvas.Handle := hdc;

  case iPartId of
    0: begin
      lCanvas.Brush.Color := CS_STATUSBAR_Panel_Separator;
      LCanvas.FillRect(prect);
    end;
    SP_PANE: begin
      LCanvas.GradientFill(pRect, CS_STATUSBAR_COLOR, CS_STATUSBAR_COLOR2, gdVertical);
    end;
    SP_GRIPPERPANE: begin
      LCanvas.GradientFill(pRect, CS_STATUSBAR_COLOR, CS_STATUSBAR_COLOR2, gdVertical);
    end;
    SP_GRIPPER: begin
      WinDrawThemeBackground(hTheme, hdc, SP_GRIPPER, iStateId,
        pRect, pClipRect);
    end;
  end;
  LCanvas.Handle := 0;
  LCanvas.Free;
end;

procedure Spin_DrawThemeBackground(hTheme: HTHEME; hdc: HDC;
  iPartId, iStateId: integer; const pRect: TRect; pClipRect: pRECT);
var
  LCanvas: TCanvas;
  AStyle: TTextStyle;
  BtnSym: string;
begin
  LCanvas := TCanvas.Create;
  LCanvas.Handle := hdc;

  case iStateId of
    1: begin
      LCanvas.Brush.Color := CS_SPIN_NORMAL;
      LCanvas.Pen.Color := CS_SPIN_NORMAL_FRAME;
    end;
    2: begin
      LCanvas.Brush.Color := CS_SPIN_HOT;
      LCanvas.Pen.Color := CS_SPIN_HOT_FRAME;
    end;
    3: begin
      LCanvas.Brush.Color := CS_SPIN_PRESSED;
      LCanvas.Pen.Color := CS_SPIN_PRESSED_FRAME;
    end;
    4: begin
      LCanvas.Brush.Color := CS_SPIN_DISABLED;
      LCanvas.Pen.Color := CS_SPIN_DISABLED_FRAME;
    end;
  end;
  AStyle := LCanvas.TextStyle;
  AStyle.Alignment := taCenter;
  AStyle.Layout := tlCenter;
  AStyle.ShowPrefix := True;
  LCanvas.Font.Size := 6;
  LCanvas.Font.Name := 'Segoe MDL2 Assets';
  lCanvas.Font.Color := CS_SPIN_ARROW;
  case iPartId of
    SPNP_UP: BtnSym := MDL_SCROLLBOX_BTNUP;
    SPNP_DOWN: BtnSym := MDL_SCROLLBOX_BTNDOWN;
    SPNP_UPHORZ: BtnSym := MDL_SCROLLBOX_BTNRIGHT;
    SPNP_DOWNHORZ: BtnSym := MDL_SCROLLBOX_BTNLEFT;
  end;
  LCanvas.FillRect(prect);
  LCanvas.Rectangle(prect);
  LCanvas.TextRect(pRect, pRect.TopLeft.X, pRect.TopLeft.Y, BtnSym, AStyle);
  LCanvas.Free;
end;

procedure ListBox_DrawThemeBackground(hTheme: HTHEME; hdc: HDC;
  iPartId, iStateId: integer; const pRect: TRect; pClipRect: pRECT);
var
  LCanvas: TCanvas;
begin
  LCanvas := TCanvas.Create;
  LCanvas.Handle := hdc;
  LCanvas.Brush.Color := CS_LISTBOX;
  LCanvas.FillRect(prect);
  LCanvas.Handle := 0;
  LCanvas.Free;
end;

procedure Trackbar_DrawThemeBackground(hTheme: HTHEME; hdc: HDC;
  iPartId, iStateId: integer; const pRect: TRect; pClipRect: pRECT);
var
  LCanvas: TCanvas;
begin
  LCanvas := TCanvas.Create;
  LCanvas.Handle := hdc;
  case iPartID of
    TKP_TRACK, TKP_TRACKVERT: begin
      LCanvas.Brush.Color := CS_TRACKBAR_TRACK_BACKGROUND;
      LCanvas.Pen.Color := CS_TRACKBAR_TRACK_FRAME;
      LCanvas.RoundRect(prect, 6, 6);
    end;
    TKP_THUMB, TKP_THUMBBOTTOM, TKP_THUMBTOP,
    TKP_THUMBVERT, TKP_THUMBLEFT, TKP_THUMBRIGHT: begin
      case iStateId of
        TUS_NORMAL: begin
          LCanvas.Brush.Color := CS_TRACKBAR_THUMB_BACKGROUND_NORMAL;
          LCanvas.Pen.Color := CS_TRACKBAR_THUMB_FRAME_NORMAL;
        end;
        TUS_HOT: begin
          LCanvas.Brush.Color := CS_TRACKBAR_THUMB_BACKGROUND_HOT;
          LCanvas.Pen.Color := CS_TRACKBAR_THUMB_FRAME_HOT;
        end;
        TUS_PRESSED: begin
          LCanvas.Brush.Color := CS_TRACKBAR_THUMB_BACKGROUND_PRESSED;
          LCanvas.Pen.Color := CS_TRACKBAR_THUMB_FRAME_PRESSED;
        end;
        TUS_FOCUSED: begin
          LCanvas.Brush.Color := CS_TRACKBAR_THUMB_BACKGROUND_FOCUSED;
          LCanvas.Pen.Color := CS_TRACKBAR_THUMB_FRAME_FOCUSED;
        end;
        TUS_DISABLED: begin
          LCanvas.Brush.Color := CS_TRACKBAR_THUMB_BACKGROUND_DISABLED;
          LCanvas.Pen.Color := CS_TRACKBAR_THUMB_FRAME_DISABLED;
        end;
      end;
      LCanvas.RoundRect(pRect, 5, 5);
    end
    else
      WinDrawThemeBackground(hTheme, hdc, iPartId, iStateId, pRect, pClipRect);
  end;
  LCanvas.Handle := 0;
  LCanvas.Free;
end;


procedure Toolbar_DrawThemeBackground(hTheme: HTHEME; hdc: HDC;
  iPartId, iStateId: integer; const pRect: TRect; pClipRect: pRECT);
const
  MDL_COMBOBOX_BTNDOWN = #$EE#$A5#$B2; // $E972
var
  LCanvas: TCanvas;
  AStyle: TTextStyle;
  BtnSym: string;
  r: TRect;
begin
  LCanvas := TCanvas.Create;
  LCanvas.Handle := hdc;
  case iPartId of

    TP_BUTTON, TP_SPLITBUTTON: begin
      case iStateid of
            {TS_NORMAL:begin
                      LCanvas.Brush.Color:=CS_TOOLBAR_BUTTON_NORMAL;
                      LCanvas.Pen.Color:=CS_TOOLBAR_BUTTON_NORMAL_FRAME;
            end;}
        TS_HOT: begin
          LCanvas.Brush.Color := CS_TOOLBAR_BUTTON_HOT;
          LCanvas.Pen.Color := CS_TOOLBAR_BUTTON_HOT_FRAME;
        end;
        TS_PRESSED: begin
          LCanvas.Brush.Color := CS_TOOLBAR_BUTTON_PRESSED;
          LCanvas.Pen.Color := CS_TOOLBAR_BUTTON_PRESSED_FRAME;
        end;
        TS_DISABLED: begin
          LCanvas.Brush.Color := CS_TOOLBAR_BUTTON_DISABLED;
          LCanvas.Pen.Color := CS_TOOLBAR_BUTTON_DISABLED_FRAME;
        end;
        TS_CHECKED: begin
          LCanvas.Brush.Color := CS_TOOLBAR_BUTTON_CHECKED;
          LCanvas.Pen.Color := CS_TOOLBAR_BUTTON_CHECKED_FRAME;
        end;
        TS_HOTCHECKED: begin
          LCanvas.Brush.Color := CS_TOOLBAR_BUTTON_HOTCHECKED;
          LCanvas.Pen.Color := CS_TOOLBAR_BUTTON_HOTCHECKED_FRAME;
        end;

        TS_NEARHOT: begin
          LCanvas.Brush.Color := CS_TOOLBAR_BUTTON_NEARHOT;
          LCanvas.Pen.Color := CS_TOOLBAR_BUTTON_NEARHOT_FRAME;
        end;
        TS_OTHERSIDEHOT: begin
          LCanvas.Brush.Color := CS_TOOLBAR_BUTTON_OTHERSIDEHOT;
          LCanvas.Pen.Color := CS_TOOLBAR_BUTTON_OTHERSIDEHOT_FRAME;
        end;
      end;
      if iStateId > 1 then LCanvas.RoundRect(prect, 2, 2);
    end;

    TP_SPLITBUTTONDROPDOWN: begin
      case iStateid of
        //TS_NORMAL:LCanvas.Brush.Color:=CS_TOOLBAR_BUTTON_NORMAL;
        TS_HOT: begin
          LCanvas.Brush.Color := CS_TOOLBAR_BUTTON_HOT;
          LCanvas.Pen.Color := CS_TOOLBAR_BUTTON_HOT_FRAME;
        end;
        TS_PRESSED: begin
          LCanvas.Brush.Color := CS_TOOLBAR_BUTTON_PRESSED;
          LCanvas.Pen.Color := CS_TOOLBAR_BUTTON_PRESSED_FRAME;
        end;
        TS_DISABLED: begin
          LCanvas.Brush.Color := CS_TOOLBAR_BUTTON_DISABLED;
          LCanvas.Pen.Color := CS_TOOLBAR_BUTTON_DISABLED_FRAME;
        end;
        TS_CHECKED: begin
          LCanvas.Brush.Color := CS_TOOLBAR_BUTTON_CHECKED;
          LCanvas.Pen.Color := CS_TOOLBAR_BUTTON_CHECKED_FRAME;
        end;
        TS_HOTCHECKED: begin
          LCanvas.Brush.Color := CS_TOOLBAR_BUTTON_HOTCHECKED;
          LCanvas.Pen.Color := CS_TOOLBAR_BUTTON_HOTCHECKED_FRAME;
        end;
        TS_NEARHOT: begin
          LCanvas.Brush.Color := CS_TOOLBAR_BUTTON_NEARHOT;
          LCanvas.Pen.Color := CS_TOOLBAR_BUTTON_NEARHOT_FRAME;
        end;
        TS_OTHERSIDEHOT: begin
          LCanvas.Brush.Color := CS_TOOLBAR_BUTTON_OTHERSIDEHOT;
          LCanvas.Pen.Color := CS_TOOLBAR_BUTTON_OTHERSIDEHOT_FRAME;
        end;
      end;
      if iStateId > 1 then
        LCanvas.RoundRect(prect, 2, 2);
    end;
    TP_SEPARATOR: begin
      LCanvas.Pen.Color := CS_TOOLBAR_SEPARATOR;
      LCanvas.Line(prect.left + (prect.Width div 2), prect.top,
        prect.left + (prect.Width div 2), prect.Height);
    end;
  end;
  if iPartID = TP_SPLITBUTTONDROPDOWN then
  begin
    AStyle := LCanvas.TextStyle;
    AStyle.Alignment := taCenter;
    AStyle.Layout := tlCenter;
    AStyle.ShowPrefix := True;
    LCanvas.Font.Name := 'Segoe MDL2 Assets';
    LCanvas.Font.Size := 6;
    BtnSym := MDL_COMBOBOX_BTNDOWN;
    LCanvas.Font.Color := CS_TOOLBAR_DROPDOWN_ARROW;
    LCanvas.TextRect(prect, pRect.TopLeft.X, pRect.TopLeft.Y, BtnSym, AStyle);
  end;

  LCanvas.Handle := 0;
  LCanvas.Free;
end;

function ToolTip_DrawThemeBackground(hTheme: HTHEME; hdc: HDC;
  iPartId, iStateId: integer; const pRect: TRect; pClipRect: pRECT): LRESULT;
var
  LCanvas: TCanvas;
begin
  LCanvas := TCanvas.Create;
  LCanvas.Handle := hdc;

  case iPartId of
    TTP_STANDARD: begin
      LCanvas.Brush.Color := CS_TOOLTIP_BACKGROUND;
      LCanvas.Pen.Color := CS_TOOPTIP_FRAME;
      LCanvas.RoundRect(prect, 0, 0);
    end;
    else
      Result := WinDrawThemeBackground(hTheme, hdc, iPartId, iStateId, pRect, pClipRect);
  end;
  LCanvas.Handle := 0;
  LCanvas.Free;

  Result := S_OK;
  exit;
end;

function ReBar_DrawThemeBackground(hTheme: HTHEME; hdc: HDC;
  iPartId, iStateId: integer; const pRect: TRect; pClipRect: prect): LRESULT;
var
  LCanvas: TCanvas;
begin
  LCanvas := TCanvas.Create;
  LCanvas.Handle := hdc;

  case iPartId of
    0: begin
      LCanvas.GradientFill(pRect, CS_REBAR_COLOR1,
        CS_REBAR_COLOR2, gdVertical);
    end;
    else
      Result := WinDrawThemeBackground(hTheme, hdc, iPartId, iStateId, pRect, pClipRect);
  end;

  LCanvas.Handle := 0;
  LCanvas.Free;

  Result := S_OK;
  exit;
end;


//Non DWM Window, Vista/Win7 classic style
function Window_DrawThemeBackground(hTheme: HTHEME; hdc: HDC;
  iPartId, iStateId: integer; const pRect: TRect; pClipRect: prect): LRESULT;
var
  LCanvas: TCanvas;
  AStyle: TTextStyle;
const
  MDL_BUTTON_MAX = WideChar($E922);   //''; // $E922
  MDL_BUTTON_MIN = WideChar($E921);   //''; // $E921
  MDL_BUTTON_RESTORE = WideChar($E923);   //''; // $E923
  MDL_BUTTON_CLOSE = WideChar($E947);   //''; // $E947
begin
  LCanvas := TCanvas.Create;
  LCanvas.Handle := hdc;

  if Win32MajorVersion=5  then
   Result := WinDrawThemeBackground(hTheme, hdc, iPartId, iStateId, pRect, pClipRect)
  else
  case iPartId of
    WP_FRAMELEFT, WP_FRAMERIGHT, WP_FRAMEBOTTOM,
    WP_SMALLFRAMELEFT, WP_SMALLFRAMERIGHT, WP_SMALLFRAMEBOTTOM: begin
      case iStateID of
        FS_ACTIVE: LCANVAS.Brush.Color := CS_TitleBar_BORDER;
        FS_INACTIVE: LCANVAS.Brush.Color := CS_TitleBar_BORDER + $050505;
      end;
      if CS_TitleBar_BORDER <> clNone then
        LCanvas.FillRect(prect)
      else
        Result := WinDrawThemeBackground(hTheme, hdc, iPartId,
          iStateId, pRect, pClipRect);
    end;
    WP_CAPTION, WP_MAXCAPTION: begin
      case iStateID of
        CS_ACTIVE: LCANVAS.Brush.Color := CS_TitleBar_Color;
        CS_INACTIVE: LCANVAS.Brush.Color := CS_TitleBar_Color + $050505;
      end;
      if CS_TitleBar_Color <> clNone then
        LCanvas.FillRect(prect)
      else
        Result := WinDrawThemeBackground(hTheme, hdc, iPartId,
          iStateId, pRect, pClipRect);
    end;
    WP_CLOSEBUTTON: begin
      if iStateId = CBS_NORMAL then
      begin
        LCANVAS.Brush.Color := CS_TitleBar_BORDER;
        LCanvas.FillRect(prect);
        AStyle := LCanvas.TextStyle;
        AStyle.Alignment := taCenter;
        AStyle.Layout := tlCenter;
        AStyle.ShowPrefix := True;
        //LCanvas.Font.Size := 6;
        LCanvas.Font.Color := CS_TitleBar_Font;
        LCanvas.Font.Name := 'Segoe MDL2 Assets';
        LCanvas.TextRect(pRect, pRect.TopLeft.X, pRect.TopLeft.Y,
          MDL_BUTTON_CLOSE, AStyle);
      end;
    end;
    WP_MINBUTTON: begin
      case iStateId of
         MINBS_NORMAL: LCANVAS.Brush.Color := CS_TitleBar_BORDER;
         MINBS_HOT:    LCANVAS.Brush.Color := clRed;
      end;
      LCanvas.FillRect(prect);
        AStyle := LCanvas.TextStyle;
        AStyle.Alignment := taCenter;
        AStyle.Layout := tlCenter;
        AStyle.ShowPrefix := True;
        LCanvas.Font.Color := CS_TitleBar_Font;
        LCanvas.Font.Name := 'Segoe MDL2 Assets';
        LCanvas.TextRect(pRect, pRect.TopLeft.X, pRect.TopLeft.Y,
          MDL_BUTTON_MIN, AStyle);
    end;
    WP_MAXBUTTON: begin
      if iStateId = MAXBS_NORMAL then
      begin
        LCANVAS.Brush.Color := CS_TitleBar_BORDER;
        LCanvas.FillRect(prect);
        AStyle := LCanvas.TextStyle;
        AStyle.Alignment := taCenter;
        AStyle.Layout := tlCenter;
        AStyle.ShowPrefix := True;
        LCanvas.Font.Color := CS_TitleBar_Font;
        LCanvas.Font.Name := 'Segoe MDL2 Assets';
        LCanvas.TextRect(pRect, pRect.TopLeft.X, pRect.TopLeft.Y,
          MDL_BUTTON_MAX, AStyle);
      end;
    end;
    WP_RESTOREBUTTON: begin
      if iStateId = RBS_NORMAL then
      begin
        LCANVAS.Brush.Color := CS_TitleBar_BORDER;
        LCanvas.FillRect(prect);
        AStyle := LCanvas.TextStyle;
        AStyle.Alignment := taCenter;
        AStyle.Layout := tlCenter;
        AStyle.ShowPrefix := True;
        LCanvas.Font.Color := CS_TitleBar_Font;
        LCanvas.Font.Name := 'Segoe MDL2 Assets';
        LCanvas.TextRect(pRect, pRect.TopLeft.X, pRect.TopLeft.Y,
          MDL_BUTTON_RESTORE, AStyle);
      end;
    end;
    else
      Result := WinDrawThemeBackground(hTheme, hdc, iPartId, iStateId, pRect, pClipRect);
  end;

  LCanvas.Handle := 0;
  LCanvas.Free;

  Result := S_OK;
  exit;
end;

function CS_DrawThemeBackground(hTheme: THandle; hdc: HDC;
  iPartId, iStateId: integer; const pRect: TRect; pClipRect: prect): HRESULT; stdcall;
var
  LCanvas: TCanvas;
begin
  if (hTheme = OpenThemeData(0, 'listbox')) then
  begin
    ListBox_DrawThemeBackground(htheme, hdc, iPartId, iStateId, pRect, pClipRect);
    Result := S_OK;
    exit;
  end;

  if (hTheme = Win32Theme.Theme[teWindow]) then
  begin
    Window_DrawThemeBackground(htheme, hdc, iPartId, iStateId, pRect, pClipRect);
    Result := S_OK;
    exit;
  end;

  if (hTheme = Win32Theme.Theme[teRebar]) then
  begin
    ReBar_DrawThemeBackground(htheme, hdc, iPartId, iStateId, pRect, pClipRect);
    Result := S_OK;
    exit;
  end;

  if (hTheme = Win32Theme.Theme[teToolTip]) then
  begin
    ToolTip_DrawThemeBackground(htheme, hdc, iPartId, iStateId, pRect, pClipRect);
    Result := S_OK;
    exit;
  end;

  if (hTheme = Win32Theme.Theme[teToolbar]) then
  begin
    Toolbar_DrawThemeBackground(htheme, hdc, iPartId, iStateId, pRect, pClipRect);
    Result := S_OK;
    exit;
  end;

  if (hTheme = Win32Theme.Theme[teTrackBar]) then
  begin
    Trackbar_DrawThemeBackground(htheme, hdc, iPartId, iStateId, pRect, pClipRect);
    Result := S_OK;
    exit;
  end;

  if (hTheme = Win32Theme.Theme[teComboBox]) then
  begin
    ComboBox_DrawThemeBackground(htheme, hdc, iPartId, iStateId, pRect, pClipRect);
    Result := S_OK;
    exit;
  end;

  if (hTheme = Win32Theme.Theme[teSpin]) then
  begin
    Spin_DrawThemeBackground(htheme, hdc, iPartId,
      iStateId, pRect, pClipRect);
    Result := S_OK;
    Exit;
  end;

  if (hTheme = Win32Theme.Theme[teButton]) then
  begin
    case iPartId of
      BP_PUSHBUTTON: begin
        Button_DrawThemeBackground(htheme, hdc, iPartId,
          iStateId, pRect, pClipRect);
        Result := S_OK;
        Exit;
      end;
      BP_CHECKBOX: begin
        DrawCheckBox(htheme, hdc, iPartId, iStateId, pRect, pClipRect);
        Result := S_OK;
        Exit;
      end;
      BP_RADIOBUTTON: begin
        DrawRadionButton(htheme, hdc, iPartId, iStateId, pRect, pClipRect);
        Result := S_OK;
        Exit;
      end;
      BP_GROUPBOX: begin
        DrawGroupBox(hTheme, hdc, iPartId, iStateId, pRect, pClipRect);
        Result := S_OK;
        Exit;
      end;
    end;
  end;

  if (hTheme = Win32Theme.Theme[teTreeview]) then
  begin
    case iPartId of
      TVP_TREEITEM: begin
        TreeView_DrawThemeBackground(hTheme, hdc,
          iPartId, iStateId, pRect, pClipRect);
        Result := S_OK;
        exit;
      end
    end;
  end;

  if (hTheme = OpenThemeData(0, 'ItemsView::ListView')) or
    (hTheme = OpenThemeData(0, 'DarkMode_Explorer::ListView')) or
    (hTheme = Win32Theme.Theme[teListView]) then
  begin
    case iPartId of
      LVP_LISTITEM: begin
        ListView_DrawThemeBackground(hTheme, hdc,
          iPartId, iStateId, pRect, pClipRect);
        Result := S_OK;
        exit;
      end;
    end;
  end;


  if (hTheme = Win32Theme.Theme[teHeader]) then
  begin
    Header_DrawThemeBackground(hTheme, hdc, iPartId, iStateId, pRect, pClipRect);
    Result := S_OK;
    exit;
  end;

  if (hTheme = Win32Theme.Theme[teMenu]) then
  begin
    Menu_DrawThemeBackground(hTheme, hdc, iPartId, iStateId, pRect, pClipRect);
    Result := S_OK;
    exit;
  end;

  if (hTheme = Win32Theme.Theme[teScrollBar]) then
  begin
    DrawScrollBar(hTheme, hdc, iPartId, iStateId, pRect, pClipRect);
    Result := S_OK;
    exit;
  end;

  if (hTheme = Win32Theme.Theme[teTab]) then
  begin
    DrawTAB(hTheme, hdc, iPartId, iStateId, pRect, pClipRect);
    Result := S_OK;
    exit;
  end;

  if (hTheme = Win32Theme.Theme[teProgress]) then
  begin
    DrawProgressBar(hTheme, hdc, iPartId, iStateId, pRect, pClipRect);
    Result := S_OK;
    exit;
  end;

  if (hTheme = Win32Theme.Theme[teStatus]) then
  begin
    DrawStatusBar(hTheme, hdc, iPartId, iStateId, pRect, pClipRect);
    Result := S_OK;
    exit;
  end;

  if (hTheme = Win32Theme.Theme[teEdit]) then
  begin
    DrawEdit(hTheme, hdc, iPartId, iStateId, pRect, pClipRect);
    Result := S_OK;
    exit;
  end;

  Result := WinDrawThemeBackground(hTheme, hdc, iPartId, iStateId, pRect, pClipRect);
end;


function BUTTON_DrawThemeText(hTheme: HTHEME; hdc: HDC; iPartId, iStateId: integer;
  pszText: LPCWSTR; iCharCount: integer; dwTextFlags, dwTextFlags2: DWORD;
  pRect: TRect): HRESULT;
begin
  SetBkMode(hdc, TRANSPARENT);
  case iPartId of
    BP_PUSHBUTTON: begin
      if iStateID = PBS_DISABLED then
        SetTextColor(hdc, COLORTORGB(CS_BUTTON_PUSHBUTTON_FONT_DISABLED))
      else
        SetTextColor(hdc, COLORTORGB(CS_BUTTON_PUSHBUTTON_FONT));
      DrawTextExW(hdc, pszText, iCharCount, @pRect, dwTextFlags, nil);
    end;
    BP_CHECKBOX: begin
      case iStateID of
        CBS_UNCHECKEDDISABLED,
        CBS_CHECKEDDISABLED,
        CBS_MIXEDDISABLED,
        CBS_IMPLICITDISABLED,
        CBS_EXCLUDEDDISABLED: SetTextColor(hdc,
            COLORTORGB(CS_BUTTON_CHECKBOX_DISABLED_FONT));
        else
          SetTextColor(hdc, COLORTORGB(CS_BUTTON_CHECKBOX_FONT));
      end;
      DrawTextExW(hdc, pszText, iCharCount, @pRect, dwTextFlags, nil);
    end;

    BP_RADIOBUTTON: begin
      case iStateID of
        RBS_UNCHECKEDDISABLED, RBS_CHECKEDDISABLED: SetTextColor(hdc,
            COLORTORGB(CS_BUTTON_RADIOBUTTON_FONT_DISABLED));
        else
          SetTextColor(hdc, COLORTORGB(CS_BUTTON_RADIOBUTTON_FONT));
      end;
      DrawTextExW(hdc, pszText, iCharCount, @pRect, dwTextFlags, nil);
    end;
    BP_GROUPBOX: begin
      SetTextColor(hdc, CS_BUTTON_GROUPBOX_Font);
      DrawTextExW(hdc, pszText, iCharCount, @pRect, dwTextFlags, nil);
    end;
    BP_USERBUTTON: begin
      SetTextColor(hdc, COLORTORGB(CS_BUTTON_USERBUTTON_FONT));
      DrawTextExW(hdc, pszText, iCharCount, @pRect, dwTextFlags, nil);
    end;
    BP_COMMANDLINK: begin
      SetTextColor(hdc, COLORTORGB(CS_BUTTON_COMMANDLINK_FONT));
      DrawTextExW(hdc, pszText, iCharCount, @pRect, dwTextFlags, nil);
    end;
  end;
end;

function CS_DrawThemeText(hTheme: HTHEME; hdc: HDC; iPartId, iStateId: integer;
  pszText: LPCWSTR; iCharCount: integer; dwTextFlags, dwTextFlags2: DWORD;
  const pRect: TRect): HRESULT;
begin

  SetBkMode(hdc, TRANSPARENT);
  SetTextColor(hdc, ColorToRGB(CS_FORM_FONT_DEFAULT));
  DrawTextExW(hdc, pszText, iCharCount, @pRect, dwTextFlags, nil);
  Result := S_OK;

  if (hTheme = Win32Theme.Theme[teButton]) then
  begin
    Button_DrawThemeText(htheme, hdc, iPartId, iStateId, pszText,
      ICharCount, dwTextFlags, dwTextFlags2, prect);
    Result := S_OK;
    Exit;
  end;
  if (hTheme = Win32Theme.Theme[teTreeview]) then
  begin
    if ipartid=TVP_TREEITEM then
    begin
    SetBkMode(hdc, TRANSPARENT);
    SetTextColor(hdc, COLORTORGB(CS_TREEVIEW_FONT));
    DrawTextExW(hdc, pszText, iCharCount, @pRect, dwTextFlags, nil);
    Result := S_OK;
    Exit;

    end;
  end;

  if (hTheme = Win32Theme.Theme[teTab]) then
  begin
    SetBkMode(hdc, TRANSPARENT);
    SetTextColor(hdc, CS_TAB_FONT);
    DrawTextExW(hdc, pszText, iCharCount, @pRect, dwTextFlags, nil);
    Result := S_OK;
    Exit;
  end;
  if (hTheme = Win32Theme.Theme[teMenu]) then
  begin
    SetBkMode(hdc, TRANSPARENT);
    case iPartId of
      MENU_BARITEM: begin
        if iStateId in [MBI_DISABLED, MBI_DISABLEDHOT, MBI_DISABLEDPUSHED] then
          SetTextColor(hdc, CS_MENU_ITEM_DISABLED_FONT)
        else
          SetTextColor(hdc, CS_MENU_FONT);
        DrawTextExW(hdc, pszText, iCharCount, @pRect, dwTextFlags, nil);
        Result := S_OK;
        Exit;
      end;
      MENU_POPUPITEM: begin
        SetTextColor(hdc, CS_POPUPMENU_FONT);
        DrawTextExW(hdc, pszText, iCharCount, @pRect, dwTextFlags, nil);
        Result := S_OK;
        Exit;
      end;
    end;

  end;
  if (hTheme = Win32Theme.Theme[teToolBar]) then
  begin
    SetBkMode(hdc, TRANSPARENT);
    SetTextColor(hdc, CS_TOOLBAR_FONT);
    DrawTextExW(hdc, pszText, iCharCount, @pRect, dwTextFlags, nil);
    Result := S_OK;
    Exit;
  end;
  if (hTheme = Win32Theme.Theme[teStatus]) then
  begin
    SetBkMode(hdc, TRANSPARENT);
    SetTextColor(hdc, CS_STATUSBAR_Font);
    DrawTextExW(hdc, pszText, iCharCount, @pRect, dwTextFlags, nil);
    Result := S_OK;
    exit;
  end;

  if (hTheme = Win32Theme.Theme[teComboBox]) then
  begin
    SetBkMode(hdc, TRANSPARENT);
    SetTextColor(hdc, CS_COMBOBOX_TEXT);
    DrawTextExW(hdc, pszText, iCharCount, @pRect, dwTextFlags, nil);
    Result := S_OK;
    exit;
  end;

  if (hTheme = Win32Theme.Theme[teToolTip]) then
  begin
    SetBkMode(hdc, TRANSPARENT);
    SetTextColor(hdc, CS_TOOLTIP_FONT);
    DrawTextExW(hdc, pszText, iCharCount, @pRect, dwTextFlags, nil);
    Result := S_OK;
    exit;
  end;

  if (hTheme = Win32Theme.Theme[teHEader]) then
  begin
    SetBkMode(hdc, TRANSPARENT);
    SetTextColor(hdc, CS_HEADER_FONT);
    DrawTextExW(hdc, pszText, iCharCount, @pRect, dwTextFlags, nil);
    Result := S_OK;
    exit;
  end;



end;

end.

