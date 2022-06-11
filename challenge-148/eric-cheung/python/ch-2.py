## Credit:
## https://theweeklychallenge.org/blog/perl-weekly-challenge-148/
## https://github.com/Anshumanmahan/Cardano-Triplets/blob/master/CardanoTriplets.py
## https://medium.com/swift-programming/cardano-triplets-in-swift-114692293795

import math

nCount = 0
nCountMax = 5

nNumMax = 200

for nNum_01 in range(1, nNumMax):
    for nNum_02 in range(1, nNumMax):
        for nNum_03 in range(1, nNumMax):
            x = nNum_01 - nNum_02 * math.sqrt(nNum_03)

            if (x > 0):
                y = math.pow(x, float(1) / 3)
            else:
                y = - math.pow(abs(x), float(1) / 3)

            z = math.pow(nNum_01 + nNum_02 * math.sqrt(nNum_03), float(1) / 3.0) + y

            ## Floating Point Rounding Errors
            if (z > 0.999999 and z < 1.000001):
                nCount = nCount + 1
                print(nNum_01, nNum_02, nNum_03)

            if (nCount == nCountMax):
                break;

        if (nCount == nCountMax):
            break;

    if (nCount == nCountMax):
        break;

## Results
## 2 1 5
## 5 1 52
## 5 2 13
## 8 1 189
## 8 3 21
