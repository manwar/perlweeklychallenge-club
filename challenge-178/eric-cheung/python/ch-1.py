
## Remarks
## https://rosettacode.org/wiki/Imaginary_base_numbers#Python

import math
import re
 
def inv(c):
    denom = c.real * c.real + c.imag * c.imag
    return complex(c.real / denom, -c.imag / denom)
 
class QuaterImaginary:

    twoI = complex(0, 2)
    invTwoI = inv(twoI)
 
    def __init__(self, str):

        if not re.match("^[0123.]+$", str) or str.count(".") > 1:
            raise Exception('Invalid base 2i number')

        self.b2i = str
 
    def toComplex(self):

        pointPos = self.b2i.find(".")
        posLen = len(self.b2i) if (pointPos < 0) else pointPos

        sum = complex(0, 0)
        prod = complex(1, 0)

        for j in range(0, posLen):
            k = int(self.b2i[posLen - 1 - j])
            if k > 0:
                sum = sum + prod * k

            prod = prod * QuaterImaginary.twoI

        if pointPos != -1:
            prod = QuaterImaginary.invTwoI
            for j in range(posLen + 1, len(self.b2i)):
                k = int(self.b2i[j])
                if k > 0:
                    sum = sum + prod * k

                prod = prod * QuaterImaginary.invTwoI

        return sum
 
    def __str__(self):
        return str(self.b2i)
 
def toQuaterImaginary(c):
    if c.real == 0.0 and c.imag == 0.0:
        return QuaterImaginary("0")
 
    re = int(c.real)
    im = int(c.imag)

    fi = -1
    ss = ""

    while re != 0:
        re, rem = divmod(re, -4)

        if rem < 0:
            rem = rem + 4
            re = re + 1

        ss = ss + str(rem) + "0"

    if im != 0:

        f = c.imag / 2
        im = int(math.ceil(f))

        f = -4 * (f - im)
        index = 1

        while im != 0:
            im, rem = divmod(im, -4)

            if rem < 0:
                rem += 4
                im += 1

            if index < len(ss):
                ss[index] = str(rem)
            else:
                ss = ss + "0" + str(rem)

            index = index + 2

        fi = int(f)

    ss = ss[::-1]

    if fi != -1:
        ss = ss + "." + str(fi)

    ss = ss.lstrip("0")

    if ss[0] == ".":
        ss = "0" + ss

    return QuaterImaginary(ss)

def formatComplex(cInput):

    strC = str(cInput)
    strC = strC.replace("+", " + ")
    strC = strC.replace("-", " - ")

    return strC


for i in range(1, 17):

    c1 = complex(i, 0)
    q1 = toQuaterImaginary(c1)
    c2 = q1.toComplex()

    print (formatComplex(c1) + " <--> " + formatComplex(q1) + " <--> " + formatComplex(c2))

    c1 = -c1
    q1 = toQuaterImaginary(c1)
    c2 = q1.toComplex()

    print (formatComplex(c1) + " <--> " + formatComplex(q1) + " <--> " + formatComplex(c2))

    print ()


print ()

 
for i in range(1, 17):

    c1 = complex(0, i)
    q1 = toQuaterImaginary(c1)
    c2 = q1.toComplex()

    print (formatComplex(c1) + " <--> " + formatComplex(q1) + " <--> " + formatComplex(c2))
 
    c1 = -c1
    q1 = toQuaterImaginary(c1)
    c2 = q1.toComplex()

    print (formatComplex(c1) + " <--> " + formatComplex(q1) + " <--> " + formatComplex(c2))
    
    print ()

