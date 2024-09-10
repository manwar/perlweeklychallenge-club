
import sys
import random

objFile = open(sys.argv[0], "r")

arrContent = objFile.readlines()

arrOutput = []
for strLoop in arrContent:
    strLoop = strLoop.replace("\n", "")
    if not strLoop:
        continue
    arrOutput = arrOutput + strLoop.split(" ")

## print (arrOutput)

print (arrOutput[random.randrange(len(arrOutput))])
