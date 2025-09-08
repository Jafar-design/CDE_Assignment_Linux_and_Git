#!/bin/bash

echo "Executing the env"

source ./.env

echo "===Done sourcing my env variables==="

echo "=====--Solution to Question 1--====="
echo "===================================="
echo "Starting to download source CSV file"
echo "===================================="
curl -o "/Users/jafarakinfenwa/Documents/CDE_Bootcamp/test/raw/annual-enterprise-survey-2023-financial-year-provisional.csv" $DATASET_DOWNLOAD_LINK
echo "===================================="
echo "Source CSV file downloaded"
echo "===================================="


echo "=====--Solution to Question 2--====="
echo " "
echo " "
echo " "
echo "===================================="
echo "Starting to transform column name Variable_code to variable_code"
echo "===================================="
sed -i.backup '1s/Variable_code/variable_code/' raw/annual-enterprise-survey-2023-financial-year-provisional.csv
echo "===================================="
echo "Done transforming column name Variable_code to variable_code"
echo "===================================="

echo " "
echo " "

#addin the rm command for idempotency.

rm -r Transformed

echo "===================================="
echo "Creating a directory called Transformed"
echo "===================================="

mkdir Transformed

echo "===================================="
echo "Starting to select specific column names and saving outputs into transformed/ folder"
echo "===================================="
cut -d ',' -f 1,9,5,6 raw/annual-enterprise-survey-2023-financial-year-provisional.csv > Transformed/2023_year_finance.csv
echo "===================================="
echo "Done selecting and saving transformed data"
echo "===================================="

echo " "
echo " "

echo "===================================="
echo "Creating a directory called Gold"                                             
echo "===================================="

mkdir Gold

echo "===================================="
echo "Saving data from folder Transformed/ into folder  Gold/"
echo "===================================="

cp Transformed/2023_year_finance.csv Gold/2023_year_finance.csv

echo "============================================================="
echo "Done copying data from folder Transformed/ into folder  Gold/" 
echo "============================================================="
