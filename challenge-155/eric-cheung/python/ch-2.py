## Remarks
## Credits
## https://theweeklychallenge.org/blog/perl-weekly-challenge-155/
## https://www.geeksforgeeks.org/fibonacci-number-modulo-m-and-pisano-period/

## Python program to calculate Fibonacci no. modulo m using Pisano Period

## Calculate and return Pisano Period The length of a Pisano Period for a given m ranges from 3 to m * m
def pisanoPeriod(nNum):
    previous, current = 0, 1
    for nLoop in range(0, nNum * nNum):
        previous, current = current, (previous + current) % nNum

        ## A Pisano Period starts with 0 and 1
        if (previous == 0 and current == 1):
            return nLoop + 1

## Calculate Fn mod nNum
def fibonacciModulo(nInput, nNum):

    ## Getting the period
    pisano_period = pisanoPeriod(nNum)

    ## Taking mod of nInput with period length
    nInput = nInput % pisano_period

    previous, current = 0, 1
    if nInput == 0:
        return 0

    if nInput == 1:
        return 1

    for nLoop in range(nInput - 1):
        previous, current = current, previous + current

    return (current % nNum)


# Driver Code
if __name__ == '__main__':
	nInput = 1548276540
	nNum = 235
	print(fibonacciModulo(nInput, nNum))
