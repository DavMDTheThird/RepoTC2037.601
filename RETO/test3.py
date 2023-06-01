import pandas as pd
import numpy as np

def get_sightings(filename, focusanimal):

	# Load table
	tab = pd.read_csv(filename)

	# Find number of records and total count of animals seen
	isfocus = (tab['Animal'] == focusanimal)
	totalrecs = np.sum(isfocus)
	meancount = np.mean(tab['Count'][isfocus])

	# Return num of records and animals seen
	return totalrecs, meancount