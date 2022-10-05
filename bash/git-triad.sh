#!/usr/bin/env bash
[ ! -n $1 ] &&
git add . &&
git commit -m . &&
git push &&
exit 0

while getopts 'a:m:' OPT; do
    case "$OPT" in
        a)
            [ -z $OPT ] && git add . ||
            git add $OPT
            ;;
        m)
            [ -z $OPT ] && git commit -m . ||
            git commit -m $OPT
            ;;
        *)
            echo "usage: $0 [ -a path ] [ -m commit message ]" >&2 && exit 1
    esac
done
git push

                
