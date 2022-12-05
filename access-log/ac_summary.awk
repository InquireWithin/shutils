#!/usr/bin/gawk -f
BEGIN {
#init vars
	TOTAL=0
	err401=0
	err404=0
}

{
#for every line, add to the total and count every host connection in the as. arr.
	arr[$1] +=1
	TOTAL +=1	
}
#if 401 is standalone detected in the file, note it
/ 401 / {
	errarr[$1] +=1
	err401 +=1
}
#if 404 is standalone detected in the file, note it
/ 404 / {
	errarr[$1] +=1
	err404 +=1
}

END {
    	printf("Access Log Summary\n============\n\nTOTAL # OF ENTRIES: %d\n\
===========================================================\n\
Client\t\t\t\t\tConn.\t\tErrors\n\
===========================================================\n",TOTAL)
	#iterate here and print every connection and format it out into a table
	for (entry in arr)
		printf("%-50s\t%d\t%d\n",entry,arr[entry],errarr[entry])
		#summary section that lists out the amount of 401 and 404 errors	
	printf("===========================================================\n\nError Summary\n401 Errors: %d\n404 Errors: %d\n\
===========================================================\n",err401,err404)
	for (i in errarr)
	#noting dangerous clients that result in over 80 errors
			if (errarr[i] >= 80)
				printf("*ALERT* %d unauthorized attempts from %s\n",errarr[i],i)
printf("==========================================================\n")
}

