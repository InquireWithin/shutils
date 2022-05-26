#!/bin/sh
#recommended: AUR Helper that will function syntactically equivalent to pacman (yay, pacaur, yaourt, etc)
#backup all packages (installed through pacman or AUR helper])
#insert '1' to use default for a command line option
#use examples: 
#User who wants to use yaourt to store a backup in ~/my/backup/dir
#sh nameofthisscript.sh ~/my/backup/dir yaourt
#User who doesnt use an AUR helper, and home folder
#sh nameofthisscript.sh ~ 1
#
#meant for arch-based systems

#be aware that the first command line argument's path is relative to the current user's $HOME
TARGETDIR=
BASESYS=
cd $HOME
([[ -n $1 ]] && [[ "$1" != "1" ]]) && TARGETDIR="$1" || TARGETDIR=$HOME
!([[ -d "$TARGETDIR" ]]) && mkdir "$TARGETDIR"
echo "Backup directory: $TARGETDIR"
AUR_HELPER=pacman #default
#aur helper can be specified by command line option 2
#if command line option 2 is not length of 0, set AUR_HELPER to ARG2
([[ -z $2 ]] && [[ -e "/bin/$2" ]] || [[ $2 == '1' ]]); [[ $? -eq 1 ]] && AUR_HELPER=$2
echo "AUR Helper: $AUR_HELPER"
#[[ $3 == '-f' ]] || [[ $3 == '1' ]] && echo "using AUR HELPER $AUR_HELPER and $TARGETDIR. Is this OK? (y/n): " ; read yn; yn='n' && sh $0
echo "backing up..."
/bin/$AUR_HELPER -Qqe > "$TARGETDIR/package_list.txt"
#native package backup only
#$AUR_HELPER -Qqen > "$TARGETDIR/package_list.txt"




























