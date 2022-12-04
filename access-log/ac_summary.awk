#!/usr/bin/gawk -f
BEGIN {
	TOTAL=0
	err401=0
	err404=0
}

{
	arr[$1] +=1
	TOTAL +=1	
}
/ 401 / {
	errarr[$1] +=1
	err401 +=1
}
/ 404 / {
	errarr[$1] +=1
	err404 +=1
}

#	{print FNR}
END {
    	printf("Access Log Summary\n============\n\nTOTAL # OF ENTRIES: %d\n\
===========================================================\n\
Client\t\t\t\t\tConn.\t\tErrors\n\
===========================================================\n",TOTAL)
	#iterate here and print
	for (entry in arr)
		printf("%-50s\t%d\t%d\n",entry,arr[entry],errarr[entry])
		#else
			#printf("%-50s\t%d\t%d\n",entry,arr[entry],errarr[entry])
	printf("===========================================================\n\nError Summary\n401 Errors: %d\n404 Errors: %d\n\
===========================================================\n",err401,err404)
	for (i in errarr)
			if (errarr[i] >= 80)
				printf("*ALERT* %d unauthorized attempts from %s\n",errarr[i],i)
printf("==========================================================\n")
}

