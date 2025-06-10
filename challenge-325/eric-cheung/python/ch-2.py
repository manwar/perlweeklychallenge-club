
## Ref.:
## https://www.tutorialspoint.com/program-to-find-final-prices-with-a-special-discount-in-a-shop-in-python

## arrPrice = [8, 4, 6, 2, 3]  ## Example 1
## arrPrice = [1, 2, 3, 4, 5]  ## Example 2
arrPrice = [7, 1, 1, 5]  ## Example 3

arrOutput = []

for nIndx, nPrice in enumerate(arrPrice):
    arrDiscount = [arrPrice[nSubIndxLoop] for nSubIndxLoop in range(nIndx + 1, len(arrPrice)) if arrPrice[nSubIndxLoop] <= nPrice]

    nDiscount = (0 if len(arrDiscount) == 0 else arrDiscount[0])

    arrOutput.append(nPrice - nDiscount)

print (arrOutput)
