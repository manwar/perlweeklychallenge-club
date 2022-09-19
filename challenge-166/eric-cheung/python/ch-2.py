
## Remarks
## https://www.geeksforgeeks.org/python-union-two-lists/

arrFile_Dir_A = ["Arial.ttf", "Comic_Sans.ttf", "Georgia.ttf", "Helvetica.ttf", "Impact.otf", "Verdana.ttf", "Old_Font/"]
arrFile_Dir_B = ["Arial.ttf", "Comic_Sans.ttf", "Courier_New.ttf", "Helvetica.ttf", "Impact.otf", "Tahoma.ttf", "Verdana.ttf"]
arrFile_Dir_C = ["Arial.ttf", "Courier_New.ttf", "Helvetica.ttf", "Impact.otf", "Monaco.ttf", "Verdana.ttf"]

arrFile_Union = sorted(list(set().union(arrFile_Dir_A, arrFile_Dir_B, arrFile_Dir_C)))

## print (arrFile_Union)

print ("dir_a\t\tdir_b\t\tdir_c")

for elemLoop in arrFile_Union:

    strResult = ""
    elemOrigLoop = elemLoop
    elemLoop = elemLoop.replace("/", "")
    ## print (elemLoop)

    nCount_Dir_A = arrFile_Dir_A.count(elemOrigLoop) + arrFile_Dir_A.count(elemLoop)
    nCount_Dir_B = arrFile_Dir_B.count(elemOrigLoop) + arrFile_Dir_B.count(elemLoop)
    nCount_Dir_C = arrFile_Dir_C.count(elemOrigLoop) + arrFile_Dir_C.count(elemLoop)
    ## print (nCount_Dir_A)
    ## print (nCount_Dir_B)
    ## print (nCount_Dir_C)

    if nCount_Dir_A > 0 and nCount_Dir_B > 0 and nCount_Dir_C > 0:
        continue

    if nCount_Dir_A > 0:
        strResult = strResult + elemOrigLoop
    else:
        strResult = strResult + "\t"

    strResult = strResult + "\t"

    if nCount_Dir_B > 0:
        strResult = strResult + elemOrigLoop
    else:
        strResult = strResult + "\t"

    strResult = strResult + "\t"

    if nCount_Dir_C > 0:
        strResult = strResult + elemOrigLoop
    else:
        strResult = strResult + "\t"

    print (strResult)
