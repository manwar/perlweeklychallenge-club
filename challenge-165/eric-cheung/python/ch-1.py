
import os

strOuputHTMLFile = "OutputSVG.html"

if os.path.exists(strOuputHTMLFile):
    os.remove(strOuputHTMLFile)

os.system("echo ^<html^> >> " + strOuputHTMLFile)
os.system("echo ^<body^> >> " + strOuputHTMLFile)

os.system("echo ^<svg height = \"100\" width = \"100\"^> >> " + strOuputHTMLFile)

while True:
    objPoints = input("Input: ")

    if not objPoints:
        break

    arrPoints = objPoints.split(",")
    ## print (len(arrPoints))

    if len(arrPoints) == 2:
        os.system("echo ^<circle cx = " + "\"" + arrPoints[0] + "\" cy = \"" + arrPoints[1] + "\" r = \"4\" stroke = \"white\" stroke-width = \"1\" fill = \"red\" /^> >> " + strOuputHTMLFile)
    elif len(arrPoints) == 4:
        os.system("echo ^<line x1 = " + "\"" + arrPoints[0] + "\" y1 = \"" + arrPoints[1] + "\" x2 = \"" + arrPoints[2] + "\" y2 = \"" + arrPoints[3] + "\" style = \"stroke: rgb(0, 0, 255); stroke-width: 2\" /^> >> " + strOuputHTMLFile)

os.system("echo ^</svg^> >> " + strOuputHTMLFile)
os.system("echo ^</body^> >> " + strOuputHTMLFile)
os.system("echo ^</html^> >> " + strOuputHTMLFile)
