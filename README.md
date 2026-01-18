![License](/Images/license.svg) ![Lazarus](/Images/lazarus.svg) [![HomePage](/Images/homepage.svg)](https://www.hiperapps.com)

# SGJ LazWin32CustomAppStyle

## What's this?

Simple Style manager for Win32/64 apps created on Lazarus.

## How it works?

It's replace original window theme. It's replace original window theme. Controls Parts and States is painted by custom theming.

It's usefull for create custom Dark Mode or another theme for app.

## Requirements
* Lazarus IDE (Tested on v4.4 with FPC 3.2.2)
* [DDetours](https://github.com/MahdiSafsafi/DDetours)
* [BGRABitmap](https://github.com/bgrabitmap/) 
* [Segoe MDL2 Assets icons](https://aka.ms/SegoeFonts) (on Windows 10/11 it's installed by default)

## Compatibility
* Windows 11
* Windows 10
* Windows 8.x
* Windows 7
* Windows Vista

> [!WARNING]
> It works now, but there is no guarantee it will work in the future. 

## How to use?
Add DDetours and this src for unit path.
Open Your project *.LPR file.
Add to uses SGJ.Win32Styles, and your custom theme(example: sgj.win32styles.themes.dark).

Add after Application.Initialize; and before Application.CreateForm(...) :
  SGJ.Win32Styles.Themes.Dark.CS_SetCustomColors;
  SGJ.Win32Styles.InstallCustomStyle;

![Image1](/Images/WinAll.webp)

# Donate 

If you appreciate this project, you can support my work:

[![Donate](/Images/donate_paypal.svg)](https://paypal.me/grzegorzskulimowski)

[![Donate](/Images/donate_paypal.svg)](https://www.paypal.com/donate/?hosted_button_id=N36UEFE5LZXYS)

[![Postaw Kawę](/Images/kawa_suppi.svg)](https://suppi.pl/sgj)
