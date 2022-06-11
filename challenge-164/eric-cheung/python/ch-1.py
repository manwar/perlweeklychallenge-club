
arrPrime = []
arrIsPalindromePrime = []

def IsPrime(nInput):
    for primeLoop in arrPrime:
        ## print (primeLoop)
        if nInput % primeLoop == 0:
            return False

    return True

def IsPalindrome(strInput):
    if strInput == strInput[::-1]:
        return True

    return False

arrPrime.append(2)
arrPrime.append(3)

arrIsPalindromePrime.append(2)
arrIsPalindromePrime.append(3)

for nLoop in range(5, 1000):
    if IsPrime(nLoop):
        arrPrime.append(nLoop)
        if IsPalindrome(str(nLoop)):
            arrIsPalindromePrime.append(nLoop)

## print (arrPrime)
print (arrIsPalindromePrime)
