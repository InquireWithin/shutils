#!/usr/bin/env bash
[ -z $1 ] &&
git add . &&
git commit -m . &&
git push &&
exit 0

while getopts 'a:m:' OPT; do
    case "$OPT" in
        a)
            [ -z $OPTARG ] && git add . ||
            git add $OPTARG
            ;;
        m)
            [ -z $OPTARG ] && git commit -m . ||
            git commit -m $OPTARG
            ;;
        *)
            echo "usage: $0 [ -a path ] [ -m commit message ]" >&2 && exit 1
    esac
done
git push

                
