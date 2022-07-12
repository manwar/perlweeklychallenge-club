

def getProdFromArr(arrInput):
    nProd = 1
    for xLoop in arrInput:
        nProd = nProd * xLoop

    return nProd

arrSylvesterSeq = []

arrSylvesterSeq.append(2)

while len(arrSylvesterSeq) < 10:
    
    arrSylvesterSeq.append(getProdFromArr(arrSylvesterSeq) + 1)

print (arrSylvesterSeq)
