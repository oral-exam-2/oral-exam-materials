LIBNAME XXXXX '/home/uXXXXX';

PROC IMPORT DATAFILE = '/home/uXXXXX/cheese.csv'
	DBMS = CSV
	OUT = XXXXX.calories;
	GETNAMES = YES;
RUN;

DATA subcalories;
	SET XXXXX.calories;
	DROP date;
	IF MISSING(lactic) THEN DELETE;
	total = h2s + lactic;
RUN;

PROC SORT DATA = subcalories OUT = XXXXX.sortcalories;
	BY lactic;
RUN;

PROC PRINT DATA = XXXXX.sortcalories;
RUN;
