# CoA synthesis pathway
#
# Description: This script is to install obtain CoA biosynthesis pathway through retropath2.0
#
# Written by: Eric Juo
#
# First written: Feb 01,2024
# Last modified: Feb 01,2024
#
# --------------------------------------------------
# Input files preparation
# ------------------------------------------------
# Retropath2.0 reqruies sink, source and rules files.
# 
# source-file.csv
# CoA InChI is writtern directly into source-file.csv. The following code just check existance of source-file.csv.

FILE=./source-file.csv
test -f $FILE && echo "$FILE exists."


# sink-file.csv
# sink-file.csv will be created by downloading E. Coli K12 MG1655 (iJO1366) SBML3 file from MetaNetX webstie and converting it into sink-file.csv

wget "https://www.metanetx.org/cgi-bin/mnxget/user_model/bigg_iJO1366.sbml3.xml"
python -m rptools.rpextractsink bigg_iJ01366.sbml3.xml # Need to check the output file name

# CoA will be removed from sink-file.csv before input into retropath2.0
grep -vwE "(MNXM727276)" <sink-file.csv> sink-file_without_CoA.csv

# rules-file.csv should already be downloaded in installation step. The file name is expected to be retrorules_rr01_rp2.tar.gz

FILE=./retrorules_rr01_rp2.tar.gz
test -f $FILE && echo "$FILE exists."

# --------------------------------------------------
# Retropath2.0
# -------------------------------------------------

python -m retropath2_wrapper sink-file_without_CoA.csv retrorules_rr01_rp2.tar.gz output -source_file source-file.csv -rulesfile_format tar 

echo "Retropath2.0' run successed!"

# -----------------------------------------------
# RP2paths
# ---------------------------------------------

python -m rp2paths all output.csv --outdir output # Check retropath2.0 output file name.

echo "RUN FINISHED!"


