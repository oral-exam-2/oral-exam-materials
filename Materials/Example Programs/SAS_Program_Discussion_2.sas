LIBNAME XXXXX '/home/uXXXXX/myLib';

FILENAME crabs URL 'https://www4.XXXXX.edu/~online/datasets/crabs.txt';

PROC IMPORT DATAFILE = crabs
	DBMS = TAB
	OUT = XXXXX.crabs;
	GETNAMES = YES;
RUN;

DATA XXXXX.mycrabs;
	SET XXXXX.crabs (KEEP = color spine width weight y);
	RENAME y = satellite;
	LENGTH Shell $6;
	IF color EQ 2 THEN Shell = "Light";
	ELSE IF color EQ 3 THEN Shell = "Medium";
	ELSE IF color EQ 4 THEN Shell = "Dark";
	ELSE Shell = "Darker"; 
	IF spine NE 1;
	DROP spine;
RUN;

PROC FREQ DATA = XXXXX.mycrabs;
	TABLES Shell Shell*Satellite/NOROW NOCOL;
RUN;

PROC MEANS DATA = XXXXX.mycrabs MEDIAN VAR N;
	CLASS shell;
	VAR width weight;
RUN;

PROC CORR DATA = XXXXX.mycrabs PLOTS = matrix(histogram);
	VAR width weight;
RUN;

PROC SGPLOT DATA = XXXXX.mycrabs;
	WHERE weight < 3300;
	HBAR satellite/GROUP = shell GROUPDISPLAY=CLUSTER DATALABEL
				FILLATTRS = (Transparency = 0.2)
				DATALABELATTRS = (COLOR = Green FAMILY = "Arial" SIZE = 12);
RUN;

PROC SGPLOT DATA = XXXXX.mycrabs;
	VBOX width/CATEGORY = satellite GROUP = satellite;
	SCATTER X = satellite y = width/JITTER;
RUN;

PROC SGPANEL DATA = XXXXX.mycrabs;
	PANELBY shell;
	VBOX width/CATEGORY = satellite GROUP = satellite;
	SCATTER X = satellite y = width/JITTER;
RUN;
