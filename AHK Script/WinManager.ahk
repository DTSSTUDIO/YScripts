; v1.1.31.01'de tüm desktoplarda çalışır

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance Force
    
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#Persistent
Menu, Tray, NoStandard
Menu, Tray, Add, YEmreAk, IconClicked
ResetMenuTray()

; Gizlenmiş pencereler
HidedWinId := []
HidedWinTitle := []
return

MenuHandler:
    For index, value in HidedWinTitle
    {
        If (value == A_ThisMenuItem)
        {
            ahkId := HidedWinId[index]
            ShowFromTrayWıthId(ahkId)
        }
    }
return

IconClicked:
    Run, https://www.yemreak.com
Return

ResetMenuTray()
{
    iconPath = C:\Users\Yedhrab\Google Drive\Pictures\Icons\Ico\ylogo-dark.ico
    IfExist %iconPath%
        Menu, Tray, Icon, %iconPath%, 1
    Menu, Tray, Default, YEmreAk
return
}

RunIfExist(url)
{
    Run %url% ; Windows Terminalde sorun oluşturuyor
return
}

AppendToMenu(title, path)
{
    Menu, Tray, Add, %title%, MenuHandler
    Menu, Tray, Default, %title%
    IfExist %path%
        Menu, Tray, Icon, %path%, 1
return
}

RemoveFromMenu(title)
{
    Menu, Tray, Delete, %title%
return
}

KeepInMem(ahkId, title, activePath)
{
    global HidedWinId, HidedWinTitle
    HidedWinId.Push(ahkId)
    HidedWinTitle.Push(title)
    AppendToMenu(title, activePath)
return
}

RemoveFromMem(ahkId, title)
{
    global HidedWinID, HidedWinTitle
    For index, value in HidedWinId
    {
        if(value == ahkId)
        {
            HidedWinId.RemoveAt(index)
            HidedWinTitle.RemoveAt(index)
            RemoveFromMenu(title)
            break
        }
    }
    
    if (HidedWinId.Length() == 0)
    {
        ResetMenuTray()
    }
return
}

ShowFromTrayWıthId(ahkId)
{
    WinRestore, ahk_id %ahkId%
    WinShow, ahk_id %ahkId%
    
    WinActivate, ahk_id %ahkId%
    WinWaitActive, ahk_id %ahkId%
    
    WinGetActiveTitle, title
    
    RemoveFromMem(ahkId, title)
}

ToogleTrayWithId(ahkId, mode=3)
{
    SetTitleMatchMode, %mode%
    DetectHiddenWindows, Off
    IfWinNotExist, ahk_id %ahkId%
    {
        ShowFromTrayWıthId(ahkId)
    }
    else
    {
        IfWinActive, ahk_id %ahkId%
        {
            WinGetActiveTitle, title
            WinGet, activePath, ProcessPath, A
            
            SendEvent, !{Esc} ; Bir önceki pencereye odaklanma
            WinHide, ahk_id %ahkId%
            
            KeepInMem(ahkId, title, activePath)
        }
        else
        {
            WinActivate ahk_id %ahkId%
        }
    }
    
return
}

ToggleWindow(windowName)
{
    WinGet, WinState, MinMax, %windowName%
    if (WinState == -1)
    {
        WinRestore, %windowName%
        WinActivate, %windowName%
    }
    else
    {
        IfWinActive, %windowName%
        {
            WinMinimize, %windowName%
            ; Tureng için 2 tane pencere açılıyor
            if(windowName = "Tureng Dictionary")
            {
                WinMinimize, %windowName%
            }
        }
        else
        {
            WinActivate, %windowName%
        }
        
    }
    
return
}

CreateWinByTrayWithClass(className, url, mode=3)
{
    SetTitleMatchMode, %mode%
    DetectHiddenWindows, On
    
    found := False
    WinGet, id, list, ahk_class %className%
    Loop, %id%
    {
        this_ID := id%A_Index%
        IfWinExist ahk_id %this_ID%
        {
            WinGetTitle, title
            If (title = "")
                continue
            
            ToogleTrayWithId(this_ID, mode)
            found := True
        }
    }
    If (!found)
        RunIfExist(url)
        return
}

CreateWinByTrayWithExe(exeName, url, mode=3)
{
    SetTitleMatchMode, %mode%
    DetectHiddenWindows, On
    
    found := False
    WinGet, id, list, ahk_exe %exeName%
    Loop, %id%
    {
        this_ID := id%A_Index%
        IfWinExist ahk_id %this_ID%
        {
            WinGetTitle, title
            If (title = "")
                continue
            
            ToogleTrayWithId(this_ID, mode)
            found := True
        }
    }
    If (!found)
        RunIfExist(url)
        return
}

CreateWinByTray(windowName, url, mode=3)
{
    SetTitleMatchMode, %mode%
    DetectHiddenWindows, On
    IfWinExist, %windowName%
    {
        WinGet, windowID, ID
        ToogleTrayWithId(windowID, mode)
    }
    else
    {
        RunIfExist(url)
        }
    
return
}

CreateWin(windowName, url, mode=3)
{
    
    SetTitleMatchMode, %mode%
    IfWinExist, %windowName%
        ToggleWindow(windowName)
    else
        RunIfExist(url)
        
return
}

;windowName=%A_ScriptName%ß
return

; Uygulama kısayolları Win ile başlar
#w::
    CreateWinByTray("WhatsApp", "shell:appsFolder\5319275A.WhatsAppDesktop_cv1g1gvanyjgm!WhatsAppDesktop")
return

#g::
    CreateWinByTray("GitHub Desktop", "C:\Users\Yedhrab\AppData\Local\GitHubDesktop\GitHubDesktop.exe")
return

#q::
    CreateWin("- OneNote", "shell:appsFolder\Microsoft.Office.OneNote_8wekyb3d8bbwe!microsoft.onenoteim", 2)
return

#t::
    CreateWin("Tureng Dictionary", "shell:appsFolder\24232AlperOzcetin.Tureng_9n2ce2f97t3e6!App")
return

#e::
    CreateWinByTrayWithClass("CabinetWClass", "explorer.exe", 2)
return

#c::
    CreateWinByTray("Google Calendar", "C:\Users\Yedhrab\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Chrome Apps\Google Calendar.lnk", 2)
return

; #F1::
;     CreateWinByTrayWithExe("WindowsTerminal.exe", "wt")
; return

; Dizin kısayolları PgDn ile başlar
PgDn & g::
    CreateWinByTray("GitHub", "C:\Users\Yedhrab\Documents\GitHub")
return
PgDn & s::
    CreateWinByTray("ShareX", "shell:appsFolder\19568ShareX.ShareX_egrzcvs15399j!ShareX", 2)
return
PgDn & Shift::
    CreateWinByTray("Startup", "shell:startup")
return
PgDn & i::
    CreateWinByTray("Icons", "C:\Users\Yedhrab\Google Drive\Pictures\Icons")
return
PgDn & d::
    CreateWinByTray("Downloads", "shell:downloads")
return
PgDn & u::
    CreateWinByTray("Yedhrab", "C:\Users\Yedhrab")
return

; Sık kullanılan karakterler de artık PgUp butonu ile çalışacaktır

Control & PgDn::
    Send , !{PgDn}
return
Control & PgUp::
    Send , !{PgUp}
return
