; v1.1.31.01'de tüm desktoplarda çalışır

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance Force
    
#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#MaxThreadsPerHotkey, 1 ; no re-entrant hotkey handling

; Gizlenmiş pencelerin ID'si
HidedWindows := []

UpdateMenu()
return

IconClicked:
    ToggleMemWindowWithTitle(A_ThisMenuItem)
Return

ClearAll:
    ClearAllHidedWindows()
Return

CloseApp:
    ClearAllHidedWindows()
    ExitApp
Return

class MenuObject {
    ahkID := 0
    title := ""
    iconPath := ""
}

ClearAllHidedWindows() {
    ahkIDs := GetHidedWindowsIDs()
    For index, ahkID in ahkIDs {
        ToggleWindowWithID(ahkID, True)
        WinKill, ahk_id %ahkID%
    }
}

GetHidedWindowsIDs(){
    ahkIDs := []
    global HidedWindows
    For index, item in HidedWindows {
        ahkIDs.Push(item.ahkID)
    }
return ahkIDs
}

GetHidedWindowsIDWithTitle(title){
    global HidedWindows
    For index, item in HidedWindows {
        if (item.title == title) {
            return item.ahkID
        }
    }
return 0
}

GetHidedWindowsIndexWithID(ahkID){
    global HidedWindows
    For index, item in HidedWindows {
        if (item.ahkID == ahkID) {
            return index
        }
    }
return 0
}

ToggleMemWindowWithTitle(menuName) {
    ahkID := GetHidedWindowsIDWithTitle(menuName)
    if ahkID
        ToggleWindowWithID(ahkID, True)
    else
        Run https://www.yemreak.com
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
    index := GetHidedWindowsIndexWithID(ahkID)
    if index {
        global HidedWindows
        HidedWindows.RemoveAt(index)
    }
return index
}

DropActiveWindowFromTrayMenu(){
    WinGetTitle, title, A
    Menu, Tray, Delete, %title%
    global HidedWindows
    if !HidedWindows.Length()
        Menu, Tray, Delete, Temizle
}

DropActiveWindowFromMem(){
    WinGet, ahkID, ID, A
    
return DropFromMem(ahkID)
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

AddTrayMenuIcon(title, iconPath, default=True) {
    if FileExist(iconPath) {
        Menu, Tray, Icon, %title%, %iconPath%,, 20
    } else if default {
        AddTrayMenuIcon(title, ".\res\default.ico", False)
    }
}

UpdateMenu(){
    #Persistent
    Menu, Tray, NoStandard
    Menu, Tray, Add, YEmreAk, IconClicked
    
    iconPath := ".\res\ylogo.ico"
    if FileExist(iconPath) {
        Menu, Tray, Icon, %iconPath%,, 0
        Menu, Tray, Icon, YEmreAk, %iconPath%,, 20
    }
    
    global HidedWindows
    if (HidedWindows.Length() > 0) {
        Menu, Tray, Add, Temizle, ClearAll
        Menu, Tray, Delete, Temizle
        Menu, Tray, Delete, Kapat
        
        iconPath := HidedWindows[HidedWindows.Length()].iconPath
        mainTitle := HidedWindows[HidedWindows.Length()].title
        
        For index, item in HidedWindows {
            title := item.title
            iconPath := item.iconPath
            
            Menu, Tray, Add, %title%, IconClicked
            AddTrayMenuIcon(title, iconPath)
        }
        
        Menu, Tray, Add, Temizle, ClearAll
        AddTrayMenuIcon("Temizle", ".\res\clear.ico")
        
    } else {
        mainTitle := "YEmreAk"
    }
    
    Menu, Tray, Default, %mainTitle%
    Menu, Tray, Add, Kapat, CloseApp
    AddTrayMenuIcon("Kapat", ".\res\close.ico")
}

SendActiveWindowToTray() {
    WinHide, A
    WinWaitNotActive, A
}

RestoreFocus() {
    SendEvent, !{Esc} ; Bir önceki pencereye odaklanma
    ; Eğer uyarı mesajı verilirse, odaklanma bozuluyor
}

ToggleWindowWithID(ahkID, hide=False) {
    DetectHiddenWindows, Off
    if !WinExist("ahk_id" . ahkID) {
        ShowHidedWindowWithID(ahkID)
        ActivateWindowWithID(ahkID)
        if DropActiveWindowFromMem()
            DropActiveWindowFromTrayMenu()
        UpdateMenu()
    } else {
        if WinActive("ahk_id" . ahkID) {
            if hide {
                KeepActiveWindowInMem()
                SendActiveWindowToTray()
                UpdateMenu()
                RestoreFocus()
            } else {
                WinMinimize, A
            }
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
        ToggleWindowWithID(ahkID, True)
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
            
            ToggleWindowWithID(ahkID, True)
            found := True
        }
    }
    if !found
        RunUrl(url)
}

OpenWindowByTitle(className, url, mode=3) {
    SetTitleMatchMode, %mode%
    DetectHiddenWindows, Off
    
    if WinExist(className) {
        WinGet, ahkID, ID, %className%
        ToggleWindowWithID(ahkID, False)
    } else {
        RunUrl(url)
    }
}

; ####################################################################################
; ##                                                                                ##
; ##                                   KISAYOLLAR                                   ##
; ##                                                                                ##
; ####################################################################################

; ---------------------------------- Göster / Gizle ----------------------------------
#q::
    OpenWindowByTitle("- OneNote", "shell:appsFolder\Microsoft.Office.OneNote_8wekyb3d8bbwe!microsoft.onenoteim", 2)
return

#t::
    OpenWindowByTitle("Tureng Dictionary", "shell:appsFolder\24232AlperOzcetin.Tureng_9n2ce2f97t3e6!App")
return

; --------------------------------- Tray Kısayolları ---------------------------------

#w::
    OpenWindowByTitleInTray("WhatsApp", "shell:appsFolder\5319275A.WhatsAppDesktop_cv1g1gvanyjgm!WhatsAppDesktop")
return

#g::
    OpenWindowByTitleInTray("GitHub Desktop", "C:\Users\Yedhrab\AppData\Local\GitHubDesktop\GitHubDesktop.exe")
return

#c::
    OpenWindowByTitleInTray("Clockify", "C:\Users\Yedhrab\AppData\Local\Programs\Clockify\Clockify.exe", 2)
        return
    
#x::
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

; --------------------------------- Buton Kısayolları ---------------------------------

; Değiştirilen butonları kurtarma
Control & PgDn::
    Send , !{PgDn}
return
Control & PgUp::
    Send , !{PgUp}
return
