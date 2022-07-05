
## Remarks
## https://rosettacode.org/wiki/Partition_an_integer_x_into_n_primes#Python

from itertools import combinations as cmb
 
def IsPrime(nInput):

    if nInput == 2:
        return True

    if nInput % 2 == 0:
        return False

    return all(nInput % xLoop > 0 for xLoop in range(3, int(nInput ** 0.5) + 1, 2))
 
 
def genP(nInput):

    pArr = [2]
    pArr.extend([xLoop for xLoop in range(3, nInput + 1, 2) if IsPrime(xLoop)])

    return pArr
 
 
## dataArr = [(99809, 1), (18, 2), (19, 3), (20, 4), (2017, 24), (22699, 1), (22699, 2), (22699, 3), (22699, 4), (40355, 3)]
dataArr = [(18, 2), (19, 3)]


for nNum_01, nNum_02 in data:

    nIter = iter(cmb(genP(nNum_01), nNum_02))

    while True:
        try:
            nNextSum = next(nIter)
            if sum(nNextSum) == nNum_01:

                print (" ".join([repr((nNum_01, nNum_02)), "->", " + ".join(str(nSumLoop) for nSumLoop in nNextSum)]))
                break

        except StopIteration:

            print (repr((nNum_01, nNum_02)) + " -> Not possible")
            break

