/************************************************************************************
***** Program: 	Replace Character Nulls Macro	*****
***** Author:	joshkylepearce      		*****
************************************************************************************/

/************************************************************************************
Purpose:
Replace null values of character variables with a user-inputted value.

Input Parameters:
1.	input_data	- The input dataset to perform null replacement.
2. 	value		- The value that null values should be replaced with.

Macro Usage:
1.	Run the replace_nulls_numeric macro code.
2.	Call the replace_nulls_numeric macro and enter the input parameters.
	e.g. %replace_nulls_numeric(input_data=work.library,value=0);

Note:
1. 	Input parameter 'value' is compatible with/without quotations.
************************************************************************************/

%macro replace_nulls_character(input_data,value);

/*
Account for user-input of character value with/without quotations.
This macro is applicable to character variables, and therefore 
requires a quotation for data compatability. The user-inputted value
is modified to ensure that quotations are always applied. 
1. Remove double quotations (if they exist).
2. Remove single quotations (if they exist).
3. Add double quotations.
*/
/*Remove double quotations*/
%let value = %sysfunc(compress(&value., '"'));
/*Remove single quotations*/
%let value = %sysfunc(compress(&value., "'"));
/*Add double quotations*/
%let value = %sysfunc(quote(&value.));

/*For all character variables, replace null with user-inputted value*/
data &input_data._RNC;
set &input_data.;
array variablesOfInterest _character_;
do over variablesOfInterest;
	if variablesOfInterest = '' then variablesOfInterest=&value.;
end;
run;

%mend;

/************************************************************************************
Example 1 & 2: Data Setup
************************************************************************************/

/*Create a reference table of products & product IDs*/
data product_ref_table;
input product_id product_desc $14.;
datalines;
1 Credit Card
2 Mortgage
3 Insurance
4 Savings
5 Term Deposit
6 Transactional
7 Pension
8 Personal Loan
9 Business Loan
10 Other
11 
run;

/************************************************************************************
Example 1: Macro Usage Without Quotations
************************************************************************************/

/*Call replace null character macro*/
%replace_nulls_character(product_ref_table,Unknown);

/************************************************************************************
Example 2: Macro Usage With Quotations
************************************************************************************/

/*Call replace null character macro*/
%replace_nulls_character(product_ref_table,'UNK');
