#!/usr/bin/sh
#merges two or more directories, keeps differences between them, into a single, updated, directory
# $1 - target dir 1, $2 - target dir 2, $n - target dir n
# -n "exname" will merge into a new directory with the path exname. the first argument after -n will be that directory.
# -D will delete the unmerged directories
# if -n is not used, the last directory will be the target for merging

[ $# -lt 2 ] && echo "USAGE: $0 [ -D ] [ -n new_directory_path ] dir1 dir2 ... dir n" 1>&2 && exit 1
declare -a args=("$@")
declare -i COUNT=0
#-D option specified
DELETE='false'
#name of new directory, unknown until the point that user may or may not give it on the command line or manually here
NEWDIR=
#use the last directory the user specified
LASTDIR='true'
#all directories specfied to combine together into $NEWDIR if specified. if not specified, last directory will be used
declare -a dirs
while [ $COUNT -lt $# ]; do
    if [[ ${args[$COUNT]} = '-D' ]]; then 
        DELETE='true' #delete option specified, narrow down from here
        #TODO: allow user to delete specified directories (maybe all directories specified after -D is invoked as long as -n is specified with an argument after?)
        [[ -z ${args[$COUNT+1]} ]] && DELALL='true'
    fi
    #if the next argument after a -n specified does exist, set the newdir to the argument after -n
    #or, if -n is specified but theres nothing after it, echo the error message out. set lastdir to true (use the last directory specified to merge into)
    [[ -n ${args[$COUNT+1]} ]] && [[ ${args[$COUNT]} = '-n' ]] && NEWDIR=${args[$COUNT+1]} && LASTDIR='false' && mkdir $NEWDIR || [[ ${args[$COUNT]} = '-n' ]] && [[ -z ${args[$COUNT+1]} ]] &&
        echo "No new directory specified after '-n', merging into last directory specified" 1>&2
    #place all command line arguments not already checked for here, to ensure that the user is targeting a directory
    #also dont include NEWDIR in the dirs array. the dirs array is what we merge from.
    [[ ${args[$COUNT]} != '-n' ]] && [[ ${args[$COUNT]} != $NEWDIR ]] && dirs[$COUNT]=${args[$COUNT]}
    COUNT+=1
done

#if lastdir is still true, use the last directory specified
if [[ $LASTDIR='true' ]]; then
    #newdir is equal to the last directory specified in the array
    NEWDIR=${dirs[${#dirs[@]}-1]}
    #no longer a need for the last element in $dirs
    unset $dirs[${#dirs[@]}]
fi    

#do the actual merge, dependent on if the user specified to delete all directories except the target directory
if [[ $DELALL = 'true' ]]; then
    for dir in $dirs; do
        cp -riv $dir $NEWDIR
        rm -rf $dir
    done
else
    for dir in $dirs; do
        cp -riv $dir $NEWDIR
    done
fi
