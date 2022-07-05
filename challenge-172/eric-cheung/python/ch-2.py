
## Remarks
## https://en.wikipedia.org/wiki/Five-number_summary

import numpy as np

def getFiveNumSumm(arrData):

    ## Five Number Summary
    return np.percentile(arrData, [0, 25, 50, 75, 100], interpolation = "midpoint")

arrInput = [0, 0, 1, 2, 63, 61, 27, 13]
print (getFiveNumSumm(arrInput))
