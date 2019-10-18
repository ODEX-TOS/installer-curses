#!/bin/bash

# MIT License
# 
# Copyright (c) 2019 Meyers Tom
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

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


