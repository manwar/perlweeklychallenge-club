
arrPath = ["/a/b/c/1/x.pl", "/a/b/c/d/e/2/x.pl", "/a/b/c/d/3/x.pl", "/a/b/c/4/x.pl", "/a/b/c/d/5/x.pl"]  ## Input

arrSplitPath = [strLoop.split("/") for strLoop in arrPath]
nMinArrPathLen = min([len(arrLoop) for arrLoop in arrSplitPath])

## print (arrSplitPath)
## print (nMinArrPathLen)

for nIndx in range(0, nMinArrPathLen):

    bIsSame = True
    for nLoop in range(1, len(arrPath)):
        if arrSplitPath[nLoop][nIndx] != arrSplitPath[nLoop - 1][nIndx]:
            bIsSame = False
            break

    if not bIsSame:
        break

if nIndx == 0:
    print ("")
else:
    print ("/".join(arrSplitPath[0][0:nIndx]))

## Ouput: /a/b/c
