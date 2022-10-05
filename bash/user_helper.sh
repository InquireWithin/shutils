#!/usr/bin/env bash
clear
printf "********************\n****SHELL HELPER****\n********************\n"
#user selection
SEL=
#checks if user wants to exit
EXIT=0
#keep running in a loop until user exits
while [[ $EXIT -eq 0 ]]; do
	clear
	#measures if a recognized command is found (0:1)
	SUCCESS=0
	#print menu
	printf "Choose one of the following:\n***************************\n(l)ist files in the current directory\n(s)how current directory\n(c)hange current directory\nreturn to (h)ome directory\n\n(e)dit a file\n\n(D)elete file\n\ne(X)it\n"
	#user makes selection here
	read -p "SELECTION ==> " SEL
		#if user input is 'l', display contents of current dir
		[[ $SEL = 'l' ]] && SUCCESS=1 && ls -l
		# user input = s, display present working dir
		[[ $SEL = 's' ]] && SUCCESS=1 && pwd
		# user input is c, change to a specified directory of the token CHANGE
		[[ $SEL = 'c' ]] && SUCCESS=1 && read -p "Change to what dir? " CHANGE && cd $CHANGE
		# change directory to the current user's home
		[[ $SEL = 'h' ]] && SUCCESS=1 && cd $HOME
		# edit file, $EDITOR is probably empty string, so nano is used to edit a specified file of the token EDIT
		[[ $SEL = 'e' ]] && SUCCESS=1 && read -p "what file to edit? " EDIT && nano $EDIT
		# Delete a file that a user specifies, which is the token DEL,  user must also confirm with 'YES'. If not, notify that the delete was cancelled. CONFIRM checks user response.
		[[ $SEL = 'D' ]] && SUCCESS=1 && read -p "what file to delete? " DEL && read -p "Type 'YES' to confirm deletion " CONFIRM && [ $CONFIRM = 'YES' ] && rm $DEL && echo "deleted file $DEL"
		# exit the script, must also be confirmed with 'YES'. CHECKEXIT checks user response
		[[ $SEL = 'X' ]] && SUCCESS=1 && read -p "Type 'YES' to confirm exit: " CHECKEXIT && [ $CHECKEXIT = 'YES' ] && EXIT=1
		# If this point is reached, no valid command was entered
		[[ $SUCCESS -eq 0 ]] && printf "Command not recognized... \n"
		# Allow user to read output, return to beginning of loop
		[[ $EXIT -eq 0 ]] && read -p "Press [ENTER/RETURN] to continue... "
done
#EOF
