# Retropath2 installation
#
# Description: This script is to install Retropath2 application
#
# Written by: Eric Juo
#
# First written: Feb 01, 2024
# Last modified: Feb 01,2024

# ------------------------------------------
# Prerequisites
# -----------------------------------------
# Retropath2.0 requires Python 3 and KNIME 4.6.4 or KNIME 4.7.0 version.Install through conda will install dependencies as well.
#
# ----------------------------------------
# Installation
# ---------------------------------------
# The following is code for installing through conda. It is recommanded to create a new conda environment in case of interference from other applications. The following example create a retropath2 environment.

conda create --name retropath2 python=3.10
conda activate retropath2
conda install -c conda-forge -n retropath2 retropath2_wrapper

# ----------------------------------------
# Post installation
# ---------------------------------------
# Retropaths requires 3 input files, rules.csv, sink.csv and source.csv. Rules.csv is obtained from RetroRules, and sink.csv is downloaded from MetaNetX and converted into csv file with InChI notation.
# The following code is to download initial release of rules.csv from RetroRules website.

wget "https://zenodo.org/record/5827427/files/retrorules_rr01_rp2.tar.gz"
tar zxvf retrorules_rr01_rp2.tar.gz

# Reverse form of retrorules will be used since we are retroback to find the sink that can synthesize target chemical (source).
#

# sink.csv can be obtained from MetaNetX, but the format is SBML3, which reqruire further processing in csv file before feed into retropath2.The following code will download rptools package which contains a tools to cnovert SBML into csv files.
conda activate retropath2
conda install -c conda-forge rptools

echo "INSTALL FINISHED!"
# ------------------------------------
# END
# -----------------------------------
