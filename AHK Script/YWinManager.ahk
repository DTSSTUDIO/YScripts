; v1.1.31.01'de tüm desktoplarda çalışır

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance Force
    
#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#MaxThreadsPerHotkey, 1 ; no re-entrant hotkey handling

#Persistent
Menu, Tray, NoStandard
Menu, Tray, Add, YEmreAk, IconClicked
Menu, Tray, Default, YEmreAk

; Gizlenmiş pencelerin ID'si
HidedWindows := [{}]
return

IconClicked:
    Run, https://www.yemreak.com
Return

class MenuObject {
    ahkID := 0
    title := ""
    iconPath := ""
}

RunUrl(url) {
    Run, %url%
}

ActivateWindowWithID(ahkID) {
    WinActivate, ahk_id %ahkID%
    WinWaitActive, ahk_id %ahkID%
}

ShowHidedWindowWithID(ahkId)
{
    WinRestore, ahk_id %ahkID%
    WinShow, ahk_id %ahkID%
}

DropFromMem(ahkID){
    global HidedWindows
    For index, item in HidedWindows {
        if (item.ahkID == ahkID){
            HidedWindows.RemoveAt(index)
        }
    }
}

DropActiveWindowFromMem(){
    WinGet, ahkID, ID, A
    
    DropFromMem(ahkID)
}

KeepInMem(ahkID, title, iconPath) {
    item := new MenuObject
    
    item.ahkID := ahkID
    item.title := title
    item.iconPath := iconPath
    
    global HidedWindows
    HidedWindows.Push(item)
}

; Gizlenmeden önce kullanılmazsa id alamaz
KeepActiveWindowInMem() {
    WinGetActiveTitle, title
    WinGet, ahkID, ID, A
    WinGet, iconPath, ProcessPath, A
    
    KeepInMem(ahkID, title, iconPath)
}

SendActiveWindowToTray() {
    WinHide, A
}

RestoreFocus() {
    SendEvent, !{Esc} ; Bir önceki pencereye odaklanma
    ; Eğer uyarı mesajı verilirse, odaklanma bozuluyor
}

ToggleWindowWithID(ahkID, mode=3, hide=False) {
    SetTitleMatchMode, %mode%
    DetectHiddenWindows, Off
    
    if !WinExist("ahk_id" . ahkID) {
        ShowHidedWindowWithID(ahkID)
        ActivateWindowWithID(ahkID)
        DropActiveWindowFromMem()
    } else {
        if WinActive("ahk_id" . ahkID) {
            if hide {
                KeepActiveWindowInMem()
                SendActiveWindowToTray()
            }
            RestoreFocus()
        } else {
            ActivateWindowWithID(ahkID)
        }
    }
}

; Pencereleri gizlenebilir modda açma
OpenWindowByTitleInTray(windowName, url, mode=3) {
    SetTitleMatchMode, %mode%
    DetectHiddenWindows, On
    
    if WinExist(windowName) {
        WinGet, ahkID, ID, %windowName%
        ToggleWindowWithID(ahkID, mode, True)
    } else {
        RunUrl(url)
    }
    
}

OpenWindowByClassInTray(className, url, mode=3) {
    SetTitleMatchMode, %mode%
    DetectHiddenWindows, On
    
    found := False
    WinGet, IDlist, list, ahk_class %className%
    Loop, %IDlist% {
        ahkID := IDlist%A_INDEX%
        if WinExist("ahk_id" . ahkID) {
            WinGetTitle, title
            if (title == "")
                continue
            
            ToggleWindowWithID(ahkID, mode, True)
            found := True
        }
    }
    if !found
        RunUrl(url)
}

; ------------------------- Kısayollar -------------------------

#w::
    OpenWindowByTitleInTray("WhatsApp", "shell:appsFolder\5319275A.WhatsAppDesktop_cv1g1gvanyjgm!WhatsAppDesktop")
return

#g::
    OpenWindowByTitleInTray("GitHub Desktop", "C:\Users\Yedhrab\AppData\Local\GitHubDesktop\GitHubDesktop.exe")
return

#c::
    OpenWindowByTitleInTray("Google Calendar", "C:\Users\Yedhrab\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Chrome Apps\Google Calendar.lnk", 2)
return

#e::
    OpenWindowByClassInTray("CabinetWClass", "explorer.exe", 2)
return

; Dizin kısayolları PgDn ile başlar
PgDn & g::
    OpenWindowByTitleInTray("GitHub", "C:\Users\Yedhrab\Documents\GitHub")
return
PgDn & s::
    OpenWindowByTitleInTray("ShareX", "shell:appsFolder\19568ShareX.ShareX_egrzcvs15399j!ShareX", 2)
return
PgDn & Shift::
    OpenWindowByTitleInTray("Startup", "shell:startup")
return
PgDn & i::
    OpenWindowByTitleInTray("Icons", "C:\Users\Yedhrab\Google Drive\Pictures\Icons")
return
PgDn & d::
    OpenWindowByTitleInTray("Downloads", "shell:downloads")
return
PgDn & u::
    OpenWindowByTitleInTray("Yedhrab", "C:\Users\Yedhrab")
return

; Değiştirilen butonları kurtarma
Control & PgDn::
    Send , !{PgDn}
return
Control & PgUp::
    Send , !{PgUp}
return
