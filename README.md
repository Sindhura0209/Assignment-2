# Assignment-2

Objective: The main objective of the project is to clean and organize data exported from ATLAS.ti about environmental policy codes. The goal is to see the frequency of cooccurrences between environmental justice frameworks, and themes.


Repository Structure
------------------------------------------------------------------------

The repository contains 2 main folders and README.md file

•	data
o	data/raw contains the excel file EJ and Maritime JET guiding principles.xlsx
o	data/processed contains the clean data after transformation
•	scripts
o	scripts/01_processing contains R script to clean raw data and export clean csv file for visualization

Data Profile
------------------------------------------------------------------------

Clean data is placed in below location: data/processed/EJT_data.csv

1.	Framework: - Character –Comprises of frameworks and themes relevant to the broader theory of Environmental Justice
2.	Cooccurrence: - Character – Describes the relative framework being compared for cooccurrence if any
3.	Frequency: - Numeric – Describes number of times the frameworks cooccur 
 


