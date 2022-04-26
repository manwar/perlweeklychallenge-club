
def getCheckDigit_13(strISBN_12):

    arrFactor = [1, 3]
    nSum = 0
    for nLoop in range(0, len(strISBN_12)):
        nSum = nSum + int(strISBN_12[nLoop]) * arrFactor[nLoop % 2]

    return (10 - nSum % 10) % 10


strISBN = "978030640615"

strISBN_Nu = "{}-{}-{}-{}".format(strISBN[:3], strISBN[3:4], strISBN[4:7], strISBN[7:])

## print ("ISBN-13 check digit for " + strISBN + " is " + str(getCheckDigit_13(strISBN)))
print ("ISBN-13 check digit for " + strISBN_Nu + " is " + str(getCheckDigit_13(strISBN)))
