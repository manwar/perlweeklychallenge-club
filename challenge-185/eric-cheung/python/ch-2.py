
## arrListInput = ['ab-cde-123', '123.abc.420', '3abc-0010.xy']  ## Example 1
arrListInput = ['1234567.a', 'a-1234-bc', 'a.b.c.d.e.f']  ## Example 2

arrListOutput = []
nMaxToMask = 4

for strLoop in arrListInput:

    strResult = ""
    nMaskCount = 0
    
    for charLoop in strLoop:

        if charLoop.isalnum() and nMaskCount < nMaxToMask:
            strResult = strResult + "x"
            nMaskCount = nMaskCount + 1
        else:
            strResult = strResult + charLoop

    arrListOutput.append(strResult)

print (arrListOutput)
