# Y Window Manager Script

Stackoverflow üzerinde yer alan açıklaması için [buraya][Stackoverflow] tıklayabilirsin.

## Removing default shortcuts

### Via Terminal Command

```sh
gsettings set org.gnome.shell.extensions.dash-to-dock hot-keys false
gsettings set org.gnome.shell.keybindings switch-to-application-1 []
gsettings set org.gnome.shell.keybindings switch-to-application-2 []
gsettings set org.gnome.shell.keybindings switch-to-application-3 []
gsettings set org.gnome.shell.keybindings switch-to-application-4 []
gsettings set org.gnome.shell.keybindings switch-to-application-5 []
gsettings set org.gnome.shell.keybindings switch-to-application-6 []
gsettings set org.gnome.shell.keybindings switch-to-application-7 []
gsettings set org.gnome.shell.keybindings switch-to-application-8 []
gsettings set org.gnome.shell.keybindings switch-to-application-9 []
```

### Via GUI of Dconf-Editor

- Install dconf-editor `sudo apt get install dconf-editor`
- Start editor `dconf-editor`
- Move `org.gnome.shell.keybindings` then click and set '[]' (del maybe)

## Making Custom Shortcuts

- Copy all text in **my script** that is in bellow
- Open terminal and type `gedit ~/Tools/ywm.sh` and paste your clipboard content
- Give executable permission `sudo chmod u+x '~/Tools/ywm.sh'`
- Press <kbd>SUPER</kbd> key and type `Shortcut`
- Scroll to the bottom of window click `+` button
- Type these command (*just example*) and set your favorite shortcut
  - For terminal, `bash -c "bash ~/Tools/ywm.sh gnome-terminal"`
  - For google chrome, `bash -c "bash ~/Tools/ywm.sh google-chrome"`
  - For Vscode, `bash -c "bash ~/Tools/ywm.sh code"`
  - For file explorer, `bash -c "bash ~/Tools/ywm.sh nautilus"`
  - For text editör, `bash -c "bash ~/Tools/ywm.sh gedit"`

### My Script

```sh
# !/bin/bash

# Window manager script
# Show, hide or create window in the current workspace with It's WM_CLASS
# $1, WM_CLASS
# $2, Optional command
# Copyright © ~ Yunus Emre Ak

# Suppose that these script written in '~/Tools/ywm.sh'

# # Need permission to work as shurtcut
# chmod u+x '~/Tools/ywm.sh'

# Getting windows id if exist
if [ ${#1} -gt 0 ]; then
    # Work only in the current workspace
    WID=$(xdotool search --desktop $(xdotool get_desktop) --classname $1)
    if [ ${#WID} -gt 0 ]; then
        # If opened more, find focused one and hide
        if [[ "$WID" =~ "$(xdotool getwindowfocus)" ]]; then
            xdotool windowminimize $(xdotool getwindowfocus)
        else
            # Open first windows if not, then try second
            let "WID1 = $(echo $WID | awk '{print $1}')"
            let "WID2 = $(echo $WID | awk '{print $2}')"
            xdotool windowactivate $WID1 || xdotool windowactivate $WID2
        fi
    else
        # If optional exec not exist, execute WM_CLASS
        if [ ${#2} -gt 0 ]; then
            $2
        else
            $1
        fi
    fi
else
    echo "Need to get parameter which are 'WM_CLASS' and optional Exec"
    echo "Ex: 'bash ywm.sh chrome google-chrome'"
fi

# Shortcuts for favorite app
# bash -c "bash ~/Tools/ywm.sh gnome-terminal" # SUPER + 1
# bash -c "bash ~/Tools/ywm.sh google-chrome" # SUPER + 2
# bash -c "bash ~/Tools/ywm.sh code" # SUPER + 3
# bash -c "bash ~/Tools/ywm.sh nautilus" # SUPER + 4
# bash -c "bash ~/Tools/ywm.sh gedit" # SUPER + 4
```

[Stackoverflow]: https://stackoverflow.com/a/56327729/9770490