#!/bin/bash

name=$(basename "$0")
directory=$(printf "%s" "$0" | sed 's:'"$name"'::')

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


function getConfigFile {
    if [[ "$gpt" == "1" ]]; then
        #efi section
        if [[ "$encrypted" == "1" ]]; then
            # efi encryption section
            if [[ "$homeSize" == "-1" ]]; then
                # only root
                file="gptencrypted.yaml"
            else
                # root and home
                file="gptencryptedhome.yaml"
            fi
        else
            # efi standard section
            if [[ "$homeSize" == "-1" ]]; then
                # only root
                file="gptnormal.yaml"

            else
                # root and home
                file="gptnormalhome.yaml"
            fi
        fi
    else
        #mbr section
        #efi section
        if [[ "$encrypted" == "1" ]]; then
            # efi encryption section
            if [[ "$homeSize" == "-1" ]]; then
                # only root
                file="mbrencrypted.yaml"
            else
                # root and home
                file="mbrencryptedhome.yaml"
            fi
        else
            # efi standard section
            if [[ "$homeSize" == "-1" ]]; then
                # only root
                file="mbrnormal.yaml"

            else
                # root and home
                file="mbrnormalhome.yaml"
            fi
        fi
    fi
}

function fileSystem {
    menu "What is your main filesystem" "ext4" "filesystem" "btrfs" "filesystem"
    filesystem="$result"
}

# generate the final config to be used by the backend installer
function genConfig {
    cp "$directory""$file" data.yaml
    sed -i "s;#disk#;$device;" data.yaml
    sed -i "s;#size#;$diskSize;" data.yaml
    sed -i "s;#system#;$filesystem;" data.yaml
    sed -i "s;#epwd#;$epwd;" data.yaml
    sed -i "s;#rootsize#;$rootSize;" data.yaml
    sed -i "s;#homesize#;$homeSize;" data.yaml
    sed -i "s;#user#;$username;" data.yaml
    sed -i "s;#password#;$password;" data.yaml
    sed -i "s;#local#;$language;" data.yaml
    sed -i "s;#keymap#;$keymap;" data.yaml
    sed -i "s;#host#;$hostname;" data.yaml
    sed -i "s;#rootpwd#;$rootpwd;" data.yaml
}

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

# get the correct template file
getConfigFile

# get the language of the system
getlocal

# get the keyboard layout
getKeymap

# get the hostname and root password
getHostname

# get information about the user
getUserNameAndPassword


genConfig
