
import os

strOuputHTMLFile = "OutputLineBestFit.html"

arrX_Points = [333, 39, 140, 292, 393, 160, 362, 13, 341, 320, 109, 203, 343, 225, 23, 282, 284, 205, 297, 292, 339, 327, 253, 61, 128, 346, 316, 124, 65, 159, 212, 337, 215, 153, 390, 100, 76, 77, 69, 92, 275, 250, 34, 213, 186, 189, 361, 363]

arrY_Points = [129, 189, 156, 134, 52, 166, 122, 193, 104, 113, 177, 152, 100, 110, 186, 102, 98, 133, 114, 126, 112, 79, 136, 169, 176, 72, 103, 162, 181, 137, 116, 86, 136, 137, 104, 180, 188, 181, 195, 186, 96, 147, 174, 134, 129, 154, 82, 89]

nNumElem = len(arrX_Points)
nSumX = sum(arrX_Points)
nSumY = sum(arrY_Points)
nSumXX = sum([xElem * xElem for xElem in arrX_Points])
nSumXY = sum([xElem * yElem for xElem, yElem in zip(arrX_Points, arrY_Points)])

dBestFitSlope = (nNumElem * nSumXY - nSumX * nSumY) / (nNumElem * nSumXX - nSumX * nSumX)
dBestFitIntercept = (nSumY - dBestFitSlope * nSumX) / nNumElem

nBestFit_X_01 = min(arrX_Points)
nBestFit_Y_01 = int(dBestFitSlope * nBestFit_X_01 + dBestFitIntercept)

nBestFit_X_02 = max(arrX_Points)
nBestFit_Y_02 = int(dBestFitSlope * nBestFit_X_02 + dBestFitIntercept)

## print (dBestFitSlope)
## print (dBestFitIntercept)

if os.path.exists(strOuputHTMLFile):
    os.remove(strOuputHTMLFile)

os.system("echo ^<html^> >> " + strOuputHTMLFile)
os.system("echo ^<body^> >> " + strOuputHTMLFile)

os.system("echo ^<svg height = \"400\" width = \"400\"^> >> " + strOuputHTMLFile)

## All Points
for indx in range(0, nNumElem):
    os.system("echo ^<circle cx = " + "\"" + str(arrX_Points[indx]) + "\" cy = \"" + str(arrY_Points[indx]) + "\" r = \"4\" stroke = \"white\" stroke-width = \"1\" fill = \"red\" /^> >> " + strOuputHTMLFile)

## Best Fit Line
os.system("echo ^<line x1 = " + "\"" + str(nBestFit_X_01) + "\" y1 = \"" + str(nBestFit_Y_01) + "\" x2 = \"" + str(nBestFit_X_02) + "\" y2 = \"" + str(nBestFit_Y_02) + "\" style = \"stroke: rgb(0, 0, 255); stroke-width: 2\" /^> >> " + strOuputHTMLFile)

os.system("echo ^</svg^> >> " + strOuputHTMLFile)
os.system("echo ^</body^> >> " + strOuputHTMLFile)
os.system("echo ^</html^> >> " + strOuputHTMLFile)
