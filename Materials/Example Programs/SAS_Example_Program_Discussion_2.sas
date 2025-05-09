LIBNAME XXXXX '/home/uXXXXX/myLib';

FILENAME house URL 'https://www4.XXXXX.edu/~online/datasets/BostonHouseTrain.csv';

PROC IMPORT DATAFILE = house
	DBMS = CSV
	OUT = XXXXX.housing;
	GETNAMES = YES;
RUN;

DATA XXXXX.myhousing;
	SET XXXXX.housing (DROP = VAR1);
	IF MEDV < 25 THEN Value = 'low';
	ELSE IF MEDV < 35 THEN Value = 'med';
	ELSE Value = 'high';
	IF ZN EQ 0;
	DROP ZN;
RUN;

PROC FREQ DATA = XXXXX.myhousing;
	TABLES CHAS Value CHAS*Value/NOCUM NOROW NOCOL;
RUN;

PROC MEANS DATA = XXXXX.myhousing MEAN MEDIAN STDDEV N;
	CLASS Value;
	VAR Tax;
RUN;

PROC UNIVARIATE DATA = XXXXX.myhousing;
	VAR NOX AGE;
RUN;

PROC CORR DATA = XXXXX.myhousing;
	VAR CRIM NOX RM AGE;
RUN;

PROC SGPLOT DATA = XXXXX.myhousing;
	VBAR Value/GROUP = CHAS GROUPDISPLAY=CLUSTER DATALABEL
				FILLATTRS = (Transparency = 0.2)
				DATALABELATTRS = (COLOR = Brown FAMILY = "Arial" SIZE = 8 STYLE = italic WEIGHT = bold);
RUN;

PROC SGPLOT DATA = XXXXX.myhousing;
	WHERE INDUS < 25;
	HISTOGRAM MEDV;
	DENSITY MEDV/ TYPE = kernel;
RUN;

PROC SGPANEL DATA = XXXXX.myhousing;
	PANELBY CHAS;
	WHERE INDUS < 25;
	HISTOGRAM MEDV;
	DENSITY MEDV/ TYPE = kernel;
RUN;

