
## Ref.:
## https://leetcode.com/problems/calculate-amount-paid-in-taxes/description/

## Example 1
nIncome = 10
arrTax = [[3, 50], [7, 10], [12, 25]]

## Example 2
## nIncome = 2
## arrTax = [[1, 0], [4, 25], [5, 50]]

## Example 3
## nIncome = 0
## arrTax = [[2, 50]]

nBalance = nIncome
nPrevTaxCeil = 0
dTaxAmout = 0

for arrTaxPair in arrTax:
    if nBalance == 0:
        break

    nTempTax = arrTaxPair[0]
    nCeil = nTempTax - nPrevTaxCeil
    dTaxPer = arrTaxPair[1] / 100

    ## if nBalance >= nCeil:
        ## dTaxAmout = dTaxAmout + nCeil * dTaxPer
        ## nBalance = nBalance - nCeil
    ## else:
        ## dTaxAmout = dTaxAmout + nBalance * dTaxPer
        ## nBalance = 0

    nTempAmount = min(nCeil, nBalance)
    dTaxAmout = dTaxAmout + nTempAmount * dTaxPer
    nBalance = nBalance - nTempAmount

    nPrevTaxCeil = nTempTax

    ## print ("")
    ## print ("===")
    ## print (nBalance, dTaxAmout)
    ## print ("===")

print (dTaxAmout)
