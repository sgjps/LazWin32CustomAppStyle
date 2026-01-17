{
 Whats this?
       Basic Style manager for Win32 apps created with Lazarus
       It's override default Window theme parts and states.

 Author: Grzegorz Skulimowski
 Web:    www.hiperapps.com

 License: LGPL with linking exception.

 Some part of this code is delivered from uwin32widgetsetdark.pas from
 Double Commander   https://github.com/doublecmd/doublecmd

}

unit SGJ.Win32Styles;

{$mode ObjFPC}{$H+}

interface

uses
  Windows, UxTheme, Win32Themes;

type
  TDrawThemeBackground = function(hTheme: THandle; hdc: HDC;
    iPartId, iStateId: integer; const pRect: TRect;
    pClipRect: pRect): HRESULT; stdcall;

type
  TDrawThemeText = function(hTheme: HTHEME; hdc: HDC; iPartId, iStateId: integer;
    pszText: LPCWSTR; iCharCount: integer; dwTextFlags, dwTextFlags2: DWORD;
    const pRect: TRect): HRESULT; stdcall;

var
  WinDrawThemeBackground: TDrawThemeBackground= nil;
  Win32Theme: TWin32ThemeServices;

procedure InstallCustomStyle;
procedure RemoveCustomStyle;

implementation

uses
  SGJ.Win32Styles.Themes,
  {$IFDEF CS_WithSynEdit}
  synedit,
  {$EndIF}
  {$IFDEF CS_WithATSynEdit}
  ATSynEdit
  {$EndIF}
  dwmapi, themes, Win32Proc, Win32Int, Win32Extra, DDetours,
  Classes, SysUtils, StdCtrls, ExtCtrls,CommCtrl, Controls, ComCtrls, Forms, Menus,
  LCLType, fpimage, Grids, CheckLst, Graphics, bgrabitmap,
  Win32WSComCtrls, Win32WSControls, WSComCtrls, WSLCLClasses, Win32WSForms, WSForms,
  Win32WSStdCtrls, WSStdCtrls, WSMenus, Win32WSMenus;

type
  TGetSysColor = function(nIndex: integer): DWORD; stdcall;

var
  WinGetSysColor: TGetSysColor= nil;
  WinDrawThemeText: TDrawThemeText= nil;
  CustomFormWndProc: Windows.WNDPROC;

const
  CS_DEFAULT_CLASS: PWideChar = 'Explorer';

const
  ID_SUB_SCROLLBOX = 1;
  ID_SUB_LISTBOX = 2;
  ID_SUB_COMBOBOX = 3;
  ID_SUB_STATUSBAR = 4;
  ID_SUB_TRACKBAR = 5;
  ID_SUB_LISTVIEW = 6;
  ID_SUB_TOOLBAR = 7;

type
  { Controls }
  TWin32WSWinControlStyled = class(TWin32WSWinControl)
  published
    class function CreateHandle(const AWinControl: TWinControl;
      const AParams: TCreateParams): HWND; override;
  end;

  TWin32WSCustomListViewStyled = class(TWin32WSCustomListView)
  published
    class function CreateHandle(const AWinControl: TWinControl;
      const AParams: TCreateParams): HWND; override;
  end;

  { ListBox }

  TWin32WSCustomListBoxStyled = class(TWin32WSCustomListBox)
  published
    class function CreateHandle(const AWinControl: TWinControl;
      const AParams: TCreateParams): HWND; override;
  end;

  { ComboBox }

  TWin32WSCustomComboBoxStyled = class(TWin32WSCustomComboBox)
  published
    class function CreateHandle(const AWinControl: TWinControl;
      const AParams: TCreateParams): HWND; override;
  end;

  { EDIT}
  TWin32WSCustomEditStyled = class(TWin32WSCustomEdit)
  published
    class function CreateHandle(const AWinControl: TWinControl;
      const AParams: TCreateParams): HWND; override;
  end;

  { Memo}

  TWin32WSCustomMemoStyled = class(TWin32WSCustomMemo)
  published
    class function CreateHandle(const AWinControl: TWinControl;
      const AParams: TCreateParams): HWND; override;
  end;



  { PopupMenu }

  TWin32WSPopupMenuStyled = class(TWin32WSPopupMenu)
  published
    class procedure Popup(const APopupMenu: TPopupMenu; const X, Y: integer); override;
  end;

  TWin32WSCustomFormStyled = class(TWin32WSCustomForm)
  published
    class function CreateHandle(const AWinControl: TWinControl;
      const AParams: TCreateParams): HWND; override;
  end;

  { ScrollBox }

  TWin32WSScrollBoxStyled = class(TWin32WSScrollBox)
  published
    class function CreateHandle(const AWinControl: TWinControl;
      const AParams: TCreateParams): HWND; override;
  end;

type
  // Enum for DWMNCRENDERINGPOLICY
  TDWMNCRENDERINGPOLICY = (
    DWMNCRP_USEWINDOWSTYLE, // Default behavior
    DWMNCRP_DISABLED,       // Non-client rendering disabled
    DWMNCRP_ENABLED         // Non-client rendering enabled
  );
const
  //Win10 17763+
  DWMWA_USE_IMMERSIVE_DARK_MODE_OLD = 19;
  //Win10 18985+, Win11
  DWMWA_USE_IMMERSIVE_DARK_MODE = 20;
  //Win10 17763+
  DWMWA_BORDER_COLOR =34 ;
  DWMWA_CAPTION_COLOR      = 35; // Title bar background color
  DWMWA_TEXT_COLOR         = 36; // Title bar text color

  function SetDarkModeForTitleBar(hWnd: HWND; DarkMode: Bool): integer;
  var
    Policy: TDWMNCRENDERINGPOLICY;
  begin
    Result := 0;
    Policy:=DWMNCRP_ENABLED;
    DwmSetWindowAttribute(hWnd, DWMWA_NCRENDERING_POLICY, @Policy, SizeOf(Policy));
    if (Win32BuildNumber >= 17763) and (Win32BuildNumber < 18985) then
      if (DwmSetWindowAttribute(hWnd, DWMWA_USE_IMMERSIVE_DARK_MODE_OLD,
        @DarkMode, SizeOf(DarkMode)) <> S_OK) then
        Result := 1;
    if Win32BuildNumber >= 18985 then
      if (DwmSetWindowAttribute(hWnd, DWMWA_USE_IMMERSIVE_DARK_MODE,
        @DarkMode, SizeOf(DarkMode)) <> S_OK) then
        Result := 1;
  end;

  type
    TPreferredAppMode = (
      _Default,
      _AllowDark,
      _ForceDark,
      _ForceLight,
      _Max
    );

var
  SetPreferredAppMode: function(AppMode: TPreferredAppMode): TPreferredAppMode; stdcall;
procedure SetPreferredAppMode_ForceDark;
var
  LibHandle: THandle;
begin
  LibHandle := LoadLibrary('uxtheme.dll');
  if LibHandle <> 0 then
  try
    Pointer(SetPreferredAppMode) := GetProcAddress(LibHandle, MAKEINTRESOURCEA(135));
    if Assigned(SetPreferredAppMode) then
    begin
      SetPreferredAppMode(_ForceDark);
    end
    else
      raise Exception.Create('SetPreferredAppMode not found in uxtheme.dll');
  finally
    FreeLibrary(LibHandle);
  end
  else
    raise Exception.Create('Failed to load uxtheme.dll');
end;


function HookGetSysColor(nIndex: integer): DWORD; stdcall;
begin
  if nIndex = COLOR_HIGHLIGHT then
  begin
    Result := (CS_HIGHLIGHT);
    Exit;
  end;

  Result := WinGetSysColor(nIndex);
end;



function CustomDrawThemeBackground(hTheme: THandle; hdc: HDC;
  iPartId, iStateId: integer; const pRect: TRect;
  pClipRect: pRect): HRESULT; stdcall;
var
  LCanvas:TCanvas;
begin
 CS_DrawThemeBackground(htheme,hdc,iPartId,iStateId,pRect,pClipRect);
  Result := S_OK;
  exit;
  Result :=WinDrawThemeBackground(htheme,hdc,iPartId,iStateId,pRect,pClipRect);
end;



function CustomDrawThemeText(hTheme: HTHEME; hdc: HDC; iPartId, iStateId: integer;
  pszText: LPCWSTR; iCharCount: integer; dwTextFlags, dwTextFlags2: DWORD;
  const pRect: TRect): HRESULT; stdcall;
begin
 CS_DrawThemeText(htheme, hdc, iPartId,iStateId,pszText, iCharCount,dwTextFlags, dwTextFlags2, pRect);
end;


procedure InstallCustomStyle;
var
  hUxTheme: HMODULE;
  pUxTheme,
  ptUxTheme: Pointer;
  Handler: TMethod;

begin

  Win32Theme := TWin32ThemeServices(ThemeServices);
   Pointer(WinGetSysColor) := InterceptCreate(@GetSysColor, @HookGetSysColor);

 hUxTheme := GetModuleHandle('uxtheme.dll');
  if hUxTheme = 0 then
    hUxTheme := LoadLibrary('uxtheme.dll');

  if hUxTheme <> 0 then
  begin
    pUxTheme := GetProcAddress(hUxTheme, 'DrawThemeBackground');
    if Assigned(pUxTheme) then
      Pointer(WinDrawThemeBackground) :=
        InterceptCreate(pUxTheme, @CustomDrawThemeBackground);

    ptUxTheme := GetProcAddress(hUxTheme, 'DrawThemeText');
    if Assigned(ptUxTheme) then
      Pointer(WinDrawThemeText) := InterceptCreate(ptUxTheme, @CustomDrawThemeText);
  end;


  with TWinControl.Create(nil) do Free;
  RegisterWSComponent(TWinControl, TWin32WSWinControlStyled);

  WSComCtrls.RegisterCustomListView;
  RegisterWSComponent(TCustomListView, TWin32WSCustomListViewStyled);


  WSStdCtrls.RegisterCustomListBox;
  RegisterWSComponent(TCustomListBox, TWin32WSCustomListBoxStyled);

  WSStdCtrls.RegisterCustomEdit;
  RegisterWSComponent(TCustomEdit, TWin32WSCustomEditStyled);

  WSStdCtrls.RegisterCustomMemo;
  RegisterWSComponent(TCustomMemo, TWin32WSCustomMemoStyled);

  WSStdCtrls.RegisterCustomComboBox;
  RegisterWSComponent(TCustomComboBox, TWin32WSCustomComboBoxStyled);

  WSMenus.RegisterMenu;
  WSMenus.RegisterPopupMenu;
  RegisterWSComponent(TPopupMenu, TWin32WSPopupMenuStyled);

  WSForms.RegisterScrollingWinControl;

  WSForms.RegisterScrollBox;
  RegisterWSComponent(TScrollBox, TWin32WSScrollBoxStyled);

  WSForms.RegisterCustomForm;
  RegisterWSComponent(TCustomForm, TWin32WSCustomFormStyled);


end;

procedure RemoveCustomStyle;
begin
  InterceptRemove(Pointer(WinGetSysColor));
  InterceptRemove(Pointer(WinDrawThemeBackground));
  InterceptRemove(Pointer(WinDrawThemeText));
end;

function CtrlsBoxWindowProc(Window: HWND; Msg: UINT; wParam: Windows.WPARAM;
  lParam: Windows.LPARAM; uISubClass: UINT_PTR; dwRefData: DWORD_PTR): LRESULT; stdcall;
var
  DC: HDC;
  R, W: TRect;
  Delta: integer;

  cx, cy: Integer;
  RV, RH: TRect;
begin
  Result := DefSubclassProc(Window, Msg, WParam, LParam);

  if Msg = WM_NCPAINT then
  begin
    if ((GetWindowLong(Window, GWL_STYLE) and WS_VSCROLL) <>0 ) and
        ((GetWindowLong(Window, GWL_STYLE) and WS_HSCROLL) <> 0)
        then begin
    DC := GetWindowDC(Window);
    GetWindowRect(Window, R);
    OffsetRect(R, -R.Left, -R.Top);
    cx := GetSystemMetrics(SM_CXVSCROLL);
    cy := GetSystemMetrics(SM_CYHSCROLL);
    RV := R;
    RV.Left := RV.Right - cx-2;
    RV.TOP:=RV.Height-cx-2;
    FillRect(DC, RV, CreateSolidBrush(ColorToRGB(CS_FORM_COLOR_DEFAULT)));
    ReleaseDC(Window, DC);

        end;


    GetClientRect(Window, @R);
    MapWindowPoints(Window, 0, @R, 2);
    GetWindowRect(Window, @W);
    Delta := Abs(W.Top - R.Top);

    DC := GetWindowDC(Window);
    ExcludeClipRect(DC, Delta, Delta, W.Width - Delta, W.Height - Delta);
    SelectObject(DC, GetStockObject(DC_PEN));
    SelectObject(DC, GetStockObject(DC_BRUSH));
    SetDCPenColor(DC, ColorToRGB(CTRL_Border));
    SetDCBrushColor(DC, ColorToRGB(CTRL_Border2));
    Rectangle(DC, 0, 0, W.Width, W.Height);
    ReleaseDC(Window, DC);
  end;

end;

function ListViewWindowProc(Window: HWND; Msg: UINT; wParam: Windows.WPARAM;
  lParam: Windows.LPARAM; uISubClass: UINT_PTR; dwRefData: DWORD_PTR): LRESULT; stdcall;
var
  NMHdr: PNMHDR;
  NMCustomDraw: PNMCustomDraw;
var
  DC: HDC;
  R, W: TRect;
  Delta: integer;
  cy, cx : integer;
  RV, RH: TRect;
   Style: LongInt;
  _hTheme: HTHEME;
begin

  if Msg = WM_NOTIFY then
  begin
    NMHdr := PNMHDR(LParam);
    if NMHdr^.code = NM_CUSTOMDRAW then
    begin
      NMCustomDraw := PNMCustomDraw(LParam);
      case NMCustomDraw^.dwDrawStage of
        CDDS_PREPAINT:
        begin
          Result := CDRF_NOTIFYITEMDRAW;
          exit;
        end;
        CDDS_ITEMPREPAINT:
        begin
          SetTextColor(NMCustomDraw^.hdc, ColorToRGB(CS_LISTVIEW_Header_Font));
          Result := CDRF_NEWFONT;
          exit;
        end;
      end;
    end;
  end;
   Result := DefSubclassProc(Window, Msg, WParam, LParam);

  if Msg = WM_NCPAINT then
  begin
     Style := GetWindowLong(Window, GWL_STYLE);
     if (Style and WS_VSCROLL <>0) and
        (Style and WS_HSCROLL <>0)
     then
     begin
     DC := GetWindowDC(Window);
    GetWindowRect(Window, R);
    OffsetRect(R, -R.Left, -R.Top);
    cx := GetSystemMetrics(SM_CXVSCROLL);
    cy := GetSystemMetrics(SM_CYHSCROLL);
    RV := R;
    RV.Left := RV.Right - cx-2;
    RV.TOP:=RV.Height-cx-2;
    FillRect(DC, RV, CreateSolidBrush(ColorToRGB(CS_FORM_COLOR_DEFAULT)));
    ReleaseDC(Window, DC)
   end;

    GetClientRect(Window, @R);
    MapWindowPoints(Window, 0, @R, 2);
    GetWindowRect(Window, @W);
    Delta := Abs(W.Top - R.Top);

    DC := GetWindowDC(Window);
    ExcludeClipRect(DC, Delta, Delta, W.Width - Delta, W.Height - Delta);
    SelectObject(DC, GetStockObject(DC_PEN));
    SelectObject(DC, GetStockObject(DC_BRUSH));
    SetDCPenColor(DC, ColorToRGB(CTRL_Border));
    SetDCBrushColor(DC, ColorToRGB(CTRL_Border2));
    Rectangle(DC, 0, 0, W.Width, W.Height);

    ReleaseDC(Window, DC);
  end;
end;

class function TWin32WSCustomListViewStyled.CreateHandle(
  const AWinControl: TWinControl;
  const AParams: TCreateParams): HWND;
var
  P: TCreateParams;
begin
  P := AParams;
  Result := inherited CreateHandle(AWinControl, P);
  SetWindowSubclass(Result, @ListViewWindowProc, ID_SUB_LISTVIEW, 0);
  if not (csDesigning in AWinControl.ComponentState) then
  begin
    if (CS_ForceDark) and (Win32BuildNumber>=17763) then  SetWindowTheme(Result,'DarkMode_ItemsView' , nil)
    else
    if (Win32MajorVersion=6) and (Win32MinorVersion=0) then
    SetWindowTheme(Result,'Explorer' , nil)
    else
    SetWindowTheme(Result,'ItemsView' , nil);
    AWinControl.Font.Color := CS_LISTVIEW_TEXT;
    AWinControl.Color := CS_LISTVIEW_BACKGROUND;
  end;
end;

function ToolBarWindowProc(Window:HWND; Msg:UINT; wParam:Windows.WPARAM;lparam:Windows.LPARAM;uISubClass : UINT_PTR;dwRefData:DWORD_PTR):LRESULT; stdcall;
var
  DC: HDC;
  LCANVAS:TCANVAS;
  R: TRect;
begin

case Msg of
    WM_ERASEBKGND :
    begin
      DC := HDC(wParam);
      GetClientRect(Window, R);
      LCanvas:=TCanvas.Create;
      LCanvas.Handle:=DC;
      LCanvas.GradientFill(R,CS_TOOLBAR_BACKGROUND,CS_TOOLBAR_BACKGROUND2,gdVertical);
      LCanvas.Handle:=0;
      LCanvas.free;
      Result := 1;
      exit;
    end;
  else
    Result:= DefSubclassProc(Window, Msg, wParam, lParam);
  end;
end;

class function TWin32WSWinControlStyled.CreateHandle(const AWinControl: TWinControl;
  const AParams: TCreateParams): HWND;
var
  P: TCreateParams;
  LCanvas:Tcanvas;
begin
  P := AParams;

  Result := inherited CreateHandle(AWinControl, P);

  if not (csDesigning in AWinControl.ComponentState) then
  begin
    SetWindowTheme(Result, CS_DEFAULT_CLASS, nil);

     if (AWinControl is TToolBar) then
       SetWindowSubclass(Result, @ToolBarWindowProc, ID_SUB_TOOLBAR, 0);

    if (AWinControl is TCustomStringGrid) then
     SetWindowTheme(Result,'ItemsView' , nil);

    if (AWinControl is TCustomTreeView) then
    begin
       SetWindowTheme(Result, '', nil);
      if TCustomTreeView(AWinControl).BorderStyle = bsSingle then
        SetWindowSubclass(Result, @CtrlsBoxWindowProc, ID_SUB_SCROLLBOX, 0);
      AWinControl.Font.Color := CS_TREEVIEW_FONT;
      AWinControl.Color := CS_TREEVIEW_BACKGROUND;

    end;
    if (AWinControl is TCustomPanel) then
      if TCustomPanel(AWinControl).BorderStyle = bsSingle then begin
        SetWindowSubclass(Result, @CtrlsBoxWindowProc, ID_SUB_SCROLLBOX, 0);
        TCustomPanel(AWinControl).BevelOuter:=bvNone;
        TCustomPanel(AWinControl).BevelInner:=bvNone;
      end
    else
        TCustomPanel(AWinControl).BevelColor:=CTRL_Border;


    if (AWinControl is TCustomGrid) then
      if TCustomGrid(AWinControl).BorderStyle = bsSingle then
        SetWindowSubclass(Result, @CtrlsBoxWindowProc, ID_SUB_SCROLLBOX, 0);
    {$IFDEF CS_WithSynEdit}
    if (AWinControl is TSynEdit) then begin
      if TSynEdit(AWinControl).BorderStyle = bsSingle then
        SetWindowSubclass(Result, @CtrlsBoxWindowProc, ID_SUB_SCROLLBOX, 0);
        SetWindowTheme(Result,'ItemsView' , nil);
    end;
    {$ENDIF}
    {$IFDEF CS_WithATSynEdit}
    if (AWinControl is TATSynEdit) then begin
      if TATSynEdit(AWinControl).BorderStyle = bsSingle then
        SetWindowSubclass(Result, @CtrlsBoxWindowProc, ID_SUB_SCROLLBOX, 0);
        SetWindowTheme(Result,'ItemsView' , nil);
    end;
    {$ENDIF}

    if (AWinControl is TCustomCheckListBox) then
      if TCustomCheckListBox(AWinControl).BorderStyle = bsSingle then
        SetWindowSubclass(Result, @CtrlsBoxWindowProc, ID_SUB_SCROLLBOX, 0);

  end;
end;

{ ListBox }

class function TWin32WSCustomListBoxStyled.CreateHandle(const AWinControl: TWinControl;
  const AParams: TCreateParams): HWND;
var
  P: TCreateParams;
begin
  P := AParams;

  Result := inherited CreateHandle(AWinControl, P);

  if not (csDesigning in AWinControl.ComponentState) then
  begin
    SetWindowSubclass(Result, @CtrlsBoxWindowProc, ID_SUB_LISTBOX, 0);
    TCustomListBox(AWinControl).Color := CS_LISTBOX_COLOR;
    TCustomListBox(AWinControl).Font.Color := CS_LISTBOX_FONT;
  end;
end;

{ Edit }

class function TWin32WSCustomEditStyled.CreateHandle(const AWinControl: TWinControl;
  const AParams: TCreateParams): HWND;
var
  P: TCreateParams;
begin
  P := AParams;

  Result := inherited CreateHandle(AWinControl, P);
end;

{ Memo }

class function TWin32WSCustomMemoStyled.CreateHandle(const AWinControl: TWinControl;
  const AParams: TCreateParams): HWND;
var
  P: TCreateParams;
begin
  P := AParams;

  if not (csDesigning in AWinControl.ComponentState) then
  begin
    AWinControl.Color := CS_MEMO_COLOR;
    AWinControl.Font.Color := CS_MEMO_TEXT;
  end;

  Result := inherited CreateHandle(AWinControl, P);

  if not (csDesigning in AWinControl.ComponentState) then
  begin
    SetWindowSubclass(Result, @CtrlsBoxWindowProc, ID_SUB_SCROLLBOX, 0);
  end;
end;

{ ComboBox }

function ComboBoxWindowProc(Window: HWND; Msg: UINT;
  wParam: Windows.WPARAM; lparam: Windows.LPARAM; uISubClass: UINT_PTR;
  dwRefData: DWORD_PTR): LRESULT; stdcall;
var
  DC: HDC;
  ComboBox: TCustomComboBox;
begin
  case Msg of
    WM_CTLCOLORLISTBOX:
    begin
      ComboBox := TCustomComboBox(GetWin32WindowInfo(Window)^.WinControl);
      DC := HDC(wParam);
      SetBkColor(DC, ColorToRGB(CS_COMBOBOX_BACKGROUND));
      SetTextColor(DC, ColorToRGB(CS_COMBOBOX_TEXT));
      Exit(LResult(ComboBox.Brush.Reference.Handle));
    end;

  end;
  Result := DefSubclassProc(Window, Msg, wParam, lParam);
end;

class function TWin32WSCustomComboBoxStyled.CreateHandle(
  const AWinControl: TWinControl;
  const AParams: TCreateParams): HWND;
var
  Info: TComboboxInfo;
begin
  if not (csDesigning in AWinControl.ComponentState) then
  begin
    AWinControl.Color := CS_COMBOBOX_BACKGROUND;
    AWinControl.Font.Color := CS_COMBOBOX_TEXT;
  end;

  Result := inherited CreateHandle(AWinControl, AParams);

  if not (csDesigning in AWinControl.ComponentState) then
  begin
    SetWindowSubclass(Result, @ComboBoxWindowProc, ID_SUB_COMBOBOX, 0);
  end;
end;

{ PopupMenu }

procedure SetMenuBackground(Menu: HMENU);
var
  MenuInfo: TMenuInfo;
begin
  MenuInfo := Default(TMenuInfo);
  MenuInfo.cbSize := SizeOf(MenuInfo);
  MenuInfo.fMask := MIM_BACKGROUND or MIM_APPLYTOSUBMENUS;
  MenuInfo.hbrBack := CreateSolidBrush(ColorToRGB(CS_POPUPMENU_BORDER));
  SetMenuInfo(Menu, @MenuInfo);
end;

class procedure TWin32WSPopupMenuStyled.Popup(const APopupMenu: TPopupMenu;
  const X, Y: integer);
begin
  SetMenuBackground(APopupMenu.Handle);

  inherited Popup(APopupMenu, X, Y);
end;

class function TWin32WSScrollBoxStyled.CreateHandle(const AWinControl: TWinControl;
  const AParams: TCreateParams): HWND;
begin
  Result := inherited CreateHandle(AWinControl, AParams);
  if not (csDesigning in AWinControl.ComponentState) then
  begin
    if TScrollBox(AWinControl).BorderStyle = bsSingle then
    begin
      SetWindowSubclass(Result, @CTRLsBoxWindowProc, 2, 0);
    end;
  end;
end;

function GetNonClientMenuBorderRect(Window: HWND): TRect;
var
  R, W: TRect;
begin
  GetClientRect(Window, @R);
  // Map to screen coordinate space
  MapWindowPoints(Window, 0, @R, 2);
  GetWindowRect(Window, @W);
  OffsetRect(R, -W.Left, -W.Top);
  Result := Classes.Rect(R.Left, R.Top - 1, R.Right, R.Top);
end;

{ FORM }
function FormWndProc2(Window: HWnd; Msg: UInt; WParam: Windows.WParam;
  LParam: Windows.LParam): LResult; stdcall;
var
  DC: HDC;
  R: TRect;
begin
  case Msg of
    WM_NCACTIVATE,
    WM_NCPAINT:
    begin
      Result := CallWindowProc(CustomFormWndProc, Window, Msg, wParam, lParam);

      DC := GetWindowDC(Window);
      R := GetNonclientMenuBorderRect(Window);
      FillRect(DC, R, CreateSolidBrush(ColorToRGB(CS_MENU_BACKGROUND2)));
      ReleaseDC(Window, DC);
    end;
    WM_SHOWWINDOW:
    begin
      Result := CallWindowProc(CustomFormWndProc, Window, Msg, wParam, lParam);
    end
    else
    begin
      Result := CallWindowProc(CustomFormWndProc, Window, Msg, wParam, lParam);
    end;
  end;
end;
procedure DisableDWMForWindow(hWnd: HWND);
var
  Policy: TDWMNCRENDERINGPOLICY;
begin
  Policy := DWMNCRP_DISABLED;
  DwmSetWindowAttribute(hWnd, DWMWA_NCRENDERING_POLICY, @Policy, SizeOf(Policy));
end;
class function TWin32WSCustomFormStyled.CreateHandle(const AWinControl: TWinControl;
  const AParams: TCreateParams): HWND;
var
  Info: PWin32WindowInfo;
  ColorRefBG: TCOLORREF;
  ColorRefFnt: TCOLORREF;
  ColorRefBrd: TCOLORREF;
begin
  Result := inherited CreateHandle(AWinControl, AParams);

  Info := GetWin32WindowInfo(Result);

  Info^.DefWndProc := @WindowProc;

  CustomFormWndProc := Windows.WNDPROC(SetWindowLongPtrW(Result,
    GWL_WNDPROC, LONG_PTR(@FormWndProc2)));

  if not (csDesigning in AWinControl.ComponentState) then
  begin
     AWinControl.Color:= CS_FORM_COLOR_DEFAULT;
     AWinControl.Font.Color:= CS_FORM_FONT_DEFAULT;
     if TCustomForm(AWinControl).Menu<>nil then
     SetMenuBackground(TCustomForm(AWinControl).Menu.Handle);
     if (CS_ForceDark) and (Win32BuildNumber>=17763) then
        SetPreferredAppMode_ForceDark;

     if CS_DarkTitleBar then
     SetDarkModeForTitleBar(result,true)
     else
     begin
     //Windows 11 only
     ColorRefBG := ColorToRGB(CS_TitleBar_Color);
     DwmSetWindowAttribute(result, DWMWA_CAPTION_COLOR, @ColorRefBG, SizeOf(ColorRefBG));
     ColorRefFnt := ColorToRGB(CS_TitleBar_Font);
     DwmSetWindowAttribute(result, DWMWA_TEXT_COLOR, @ColorRefFnt, SizeOf(ColorRefFnt));
     ColorRefBrd := ColorToRGB(CS_TitleBar_BORDER);
     if CS_TitleBar_BORDER<>clNone then
     DwmSetWindowAttribute(result, DWMWA_BORDER_COLOR, @ColorRefBrd, SizeOf(ColorRefBrd));
     end;

     if (Win32BuildNumber>=17763) and (Win32BuildNumber<22000)
     and not CS_DarkTitleBar and CS_NoDWMForOldOS
     then
     DisableDWMForWindow(result);

     if (Win32BuildNumber<17763) and CS_NoDWMForOldOS then
     DisableDWMForWindow(result);
  end;
end;



finalization
RemoveCustomStyle;
end.
