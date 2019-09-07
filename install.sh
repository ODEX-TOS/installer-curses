#!/bin/bash

name=$(basename "$0")
directory=$(printf "%s" "$0" | sed 's:'"$name"'::')
config="/usr/share/tos-cli-installer/"
# by default no encryption
encrypted="0"
epwd=""
# EFI is the default partitiontable
gpt="1"

# if howsize is not -1 then a sepparate homepartition should be created
homeSize="-1"
rootSize="" 

source "$directory"dialog.sh



# returns the selected keymap
function getKeymap {
    menu "What is your keyboard layout" $(/usr/bin/ls /usr/share/kbd/keymaps/i386/**/*.map.gz | sed 's:.map.gz::' | xargs -n 1 basename | awk '{print $0, "keyboard"}')
    keymap="$result"
}

function getDisk {
    menu "On what disk do you wish to install TOS?" $(lsblk --noheading -p --list | awk '$6 ~ /disk/{print $1, $4}')
    device="$result"
    diskSize="$(lsblk --noheading -p --list | grep "$device" | awk '$6 ~ /disk/{print $4}')"
    rootSize="$diskSize"
}

function getlocal {
    menu "What is your language?" $(cat /etc/locale.gen | awk '$0 ~ /^#[a-zA-Z].*/' | sed 's:#::' | tr -d '\n')
    language="$result"
}

function getHostname {
    ask "What is your hostname" "tos"
    hostname="$result"
    ask "What is the root password (it is shown in plain text)" "root"
    rootpwd="$result"

}

function getUserNameAndPassword {
    ask "What is your username" "alpha"
    username="$result"
    ask "What is your password (it is shown in plain text)" "123"
    password="$result"
}

function gpt {
    ask "Do you want an EFI system or MBR?" "EFI"
    if [[ ! "$result" == "EFI" ]]; then
        gpt="0"
    fi
}

function encryption {
   ask "Do you want an encrypted drive?" "yes"
    if [[ "$result" == "yes" ]]; then
        encrypted="1"
        ask "what is the encrypted password?" "123"
        epwd="$result"
    fi 
}

function homePartition {
    ask "Do you want a separate home partiton" "yes"
    if [[ "$result" == "yes" ]]; then
        size=$(echo "${diskSize%?}" )
        type=$(echo "${diskSize: -1}")
        ask "How big do you want the home partition" "$(echo "$size" | awk '{print $1/2.1}')"
        homeSize="$result""$type"
        if [[ "$type" == "T" ]];then
            rootSize="$(echo "$size $result" | awk '{print $1 - $2 - 0.001}')""$type"
        else
            rootSize="$(echo "$size $result" | awk '{print $1 - $2 - 1}')""$type"
        fi
    fi
}

function addTotal {
    file=()

    # first add the header
    addGptOrMBR

    addEncryption

    addServer
}

function addServer {
    ask "Do you want to install the server edition or the desktop edition" "desktop"
    if [[ "$result" == "desktop" ]]; then
        file+=" standard.yaml"
    else
        file+=" server.yaml" 
    fi
}

function addGptOrMBR {
    if [[ "$gpt" == "1" ]]; then
        file+=" gpt.yaml"
    else
        file+=" mbr.yaml"
    fi
}

function addEncryption {
        if [[ "$encrypted" == "1" ]]; then
            file+=" encryption.yaml"
            # efi encryption section
            if [[ ! "$homeSize" == "-1" ]]; then
                # only root
                file+=" encryptionhome.yaml"
            fi
        else
            file+=" root.yaml"
            # efi standard section
            if [[ ! "$homeSize" == "-1" ]]; then
                file+=" home.yaml"
            fi
        fi
}



function fileSystem {
    menu "What is your main filesystem" "ext4" "filesystem" "btrfs" "filesystem"
    filesystem="$result"
}

# generate the final config to be used by the backend installer
#  $1 is the file to copy $2 is the new filename
function genConfig {
    cp "$1" "$2"
    sed -i "s;#disk#;$device;" "$2"
    sed -i "s;#size#;$diskSize;" "$2"
    sed -i "s;#system#;$filesystem;" "$2"
    sed -i "s;#epwd#;$epwd;" "$2"
    sed -i "s;#rootsize#;$rootSize;" "$2"
    sed -i "s;#homesize#;$homeSize;" "$2"
    sed -i "s;#user#;$username;" "$2"
    sed -i "s;#password#;$password;" "$2"
    sed -i "s;#local#;$language;" "$2"
    sed -i "s;#keymap#;$keymap;" "$2"
    sed -i "s;#host#;$hostname;" "$2"
    sed -i "s;#rootpwd#;$rootpwd;" "$2"
}

# merge 2 files into 1 $1 is the top part of the new file $2 is the bottom part $3 is the new File name
function mergeFiles {
        cp "$1" "$3"
        cat "$2" >> "$3"
}


function askAll {
    prmpt "This installer will override the entire disk. If you want to install onto a partition then you need to generate the config yourself. Alternativly use the graphical installer or look up a howto on the internet"
    prmpt "Setting up the disk"
    #get the disk to install tos on
    getDisk
    # detect if the user wants efi or mbr
    gpt
    # find out if the user wants encryption or not
    encryption
    #find out if the users whats a sepparate home parition
    homePartition

    fileSystem

    # get the language of the system
    getlocal

    # get the keyboard layout
    getKeymap

    # get the hostname and root password
    getHostname

    # get information about the user
    getUserNameAndPassword
} 

# interactive asker for generating the correct variables
askAll

function genFile {
    addTotal
    touch data.yaml
    for i in ${file[@]}; do
            cat "$config"$i >> data.yaml
           
    done
    #generate different part
    genConfig "data.yaml" "gen.yaml"
    os-install --in "gen.yaml" --out "run.sh"
    rm "data.yaml" "gen.yaml"
    
}

genFile
