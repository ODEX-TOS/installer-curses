#!/bin/bash

# Call this with one argument (the text inside the textbox)
function prmpt {
    dialog --title "TOS Installer" --yesno "$1" 0 0
}

# the first parameter is the question
# second parameter is the defaul answer
function ask {
    exec 3>&1;
    result=$(dialog --title "TOS Installer" --inputbox "$1" 0 0 "$2" 2>&1 1>&3);
    exec 3>&-;
}

# the first parameter is the question
# the second parameter is the name, the third is extra info
# the fourth, fifth etc are the next menu entries
# the result is the second, fourth, sixth etc element that was selected
function menu {   
    exec 3>&1;
    result=$(dialog --title "TOS installer" --menu "$1" 0 0 0 ${@:2} 2>&1 1>&3);
    exec 3>&-;
}
