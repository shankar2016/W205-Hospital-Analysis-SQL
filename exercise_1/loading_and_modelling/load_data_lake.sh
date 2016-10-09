# 
# Natarajan Shankar
# W205, Fall 2016
# Script for downloading files from the Medicare database and managing them
# October 2016:w
# 

# clean up the local directory before downloading
rm *.csv *.txt *.pdf hospitals_compare/*.csv

# Make the hospitals_compare directory to keep select ed files
mkdir -p hospitals_compare

# Get the .csv files from the Medicare Database
wget -O Hospital_Revised_Flatfiles.zip https://data.medicare.gov/views/bg9k-emty/files/Nqcy71p9Ss2RSBWDmP77H1DQXcyacr2khotGbDHHW_s?content_type=application%2Fzip%3B%20charset%3Dbinary&filename=Hospital_Revised_Flatfiles.zip  &&

# Wait for download to complete
wait

# Unzip into local directory
unzip Hospital_Revised_Flatfiles.zip

# 5 files are pointed out as being the most relevant
# For each of the 5 files, remove the header and rename with simpler names
# Copy each of the 5 files into the hospital_compare directory

tail -n+2 'Hospital General Information.csv' > hospitals.csv 
cp hospitals.csv hospitals_compare/.

tail -n+2 'Timely and Effective Care - Hospital.csv' > effective_care.csv 
cp effective_care.csv hospitals_compare/.

tail -n+2 'Readmissions and Deaths - Hospital.csv' > readmissions.csv
cp readmissions.csv hospitals_compare/.

tail -n+2 'Measure Dates.csv' > measures.csv
cp Measures.csv hospitals_compare/.

tail -n+2 'hvbp_hcahps_05_28_2015.csv' > surveys_responses.csv
cp surveys_responses.csv hospitals_compare/.

# Create a hospital_comparedirectory in HDFS if it does not exist
hdfs dfs -mkdir -p /user/w205/hospital_compare

# Now load the 5 files into HDFS
hdfs dfs -put hospitals.csv /user/w205/hospital_compare/.
hdfs dfs -put effective_care.csv /user/w205/hospital_compare/.
hdfs dfs -put readmissions.csv /user/w205/hospital_compare/.
hdfs dfs -put Measures.csv /user/w205/hospital_compare/measures.csv
hdfs dfs -put surveys_responses.csv /user/w205/hospital_compare/hospital
