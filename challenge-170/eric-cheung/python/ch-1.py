
arrPrime = [1, 2, 3, 5, 7, 11, 13, 17, 19, 23]

arrPrimorialNum = []

nProduct = 1

for primeLoop in range(0, len(arrPrime)):
    nProduct = nProduct * arrPrime[primeLoop]
    arrPrimorialNum.append(nProduct)

print (arrPrimorialNum)

