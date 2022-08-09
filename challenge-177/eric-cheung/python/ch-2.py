
arrPrime = []
arrIsPalindromePrimeCyclops = []

def IsPrime(nInput):
    for primeLoop in arrPrime:
        if nInput % primeLoop == 0:
            return False

    return True


def IsPalindrome(strInput):
    if strInput == strInput[::-1]:
        return True

    return False


def IsCyclops(nInput):
    if len(str(nInput)) % 2 == 0:
        return False

    if str(nInput).count("0") == 0 or str(nInput).count("0") > 1:
        return False

    if str(nInput)[int((len(str(nInput)) - 1) / 2)] == "0":
        return True

    return False


arrPrime.append(2)
arrPrime.append(3)

nLoop = 5
while len(arrIsPalindromePrimeCyclops) < 20:

    if IsPrime(nLoop):
        arrPrime.append(nLoop)
        if IsPalindrome(str(nLoop)) and IsCyclops(nLoop):
            arrIsPalindromePrimeCyclops.append(nLoop)

    nLoop = nLoop + 2

print (arrIsPalindromePrimeCyclops)
## [101, 16061, 31013, 35053, 38083, 73037, 74047, 91019, 94049, 1120211, 1150511, 1160611, 1180811, 1190911, 1250521, 1280821, 1360631, 1390931, 1490941, 1520251]
