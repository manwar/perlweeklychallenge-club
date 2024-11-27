
## ====
def GetZumaStr (strInput):
    arrList = []

    charPrev = ""
    nCharCount = 0

    for charLoop in strInput:
        if not charPrev:
            nCharCount = 1
        elif charLoop != charPrev:
            arrList.append([charPrev, nCharCount])
            nCharCount = 1
        else:
            nCharCount = nCharCount + 1

        charPrev = charLoop

    arrList.append([charPrev, nCharCount])

    ## print (arrList)

    arrRev = [arrLoop for arrLoop in arrList if arrLoop[1] < 3]

    if len(arrRev) == 0:
        return ["", 0, []]

    strBoardRev = "".join([arrLoop[0] * arrLoop[1] for arrLoop in arrRev])

    nMaxBall = max([arrLoop[1] for arrLoop in arrRev])

    arrMaxBall = [[arrLoop[0], sum([arrLoop[1] for arrLoop in arrRev[:nIndx]])] for nIndx, arrLoop in enumerate(arrRev) if arrLoop[1] == nMaxBall]

    arrMaxLabel = [arrLoop[0] for arrLoop in arrMaxBall]
    arrMaxCount = []
    for strBallLoop in set(arrMaxLabel):
        arrMaxCount.append([arrMaxLabel.count(strBallLoop), strBallLoop])

    arrMaxCount = sorted(arrMaxCount)
    arrMaxBallRev = []

    for arrLoop in arrMaxCount:
        arrMaxBallRev = arrMaxBallRev + [arrRowLoop for arrRowLoop in arrMaxBall if arrRowLoop[0] == arrLoop[1]]

    return [strBoardRev, nMaxBall, arrMaxBallRev]
## ====


## Example 1
## strBoard = "WRRBBW"
## strHand = "RB"


## Example 2
strBoard = "WWRRBBWW"
strHand = "WRBRW"


## Example 2
## strBoard = "G"
## strHand = "GGGGG"


objHand = {}
nHandBallCount = 0
for charLoop in set(list(strHand)):
    objHand.update({charLoop : strHand.count(charLoop)})
    nHandBallCount = nHandBallCount + strHand.count(charLoop)

## print (GetZumaStr(strBoard))
## print (objHand)

nCount = 0
strTempBoard, nMaxBall, arrMaxBall = GetZumaStr(strBoard)

while strTempBoard and nHandBallCount > 0:
    ## print (strTempBoard, "-", nMaxBall, "-", arrMaxBall)

    arrBallSel = arrMaxBall[0]

    strColorBall = arrBallSel[0]
    nColorBallPos = arrBallSel[1]

    strTempBoard = strTempBoard[:nColorBallPos] + strColorBall + strTempBoard[nColorBallPos:]

    if strColorBall not in objHand:
        break

    objHand[strColorBall] = objHand[strColorBall] - 1
    nHandBallCount = nHandBallCount - 1

    if objHand[strColorBall] == 0:
        del objHand[strColorBall]

    nCount = nCount + 1

    bLoopFlag = True
    while bLoopFlag:
        strNuTempBoard, nMaxBall, arrMaxBall = GetZumaStr(strTempBoard)

        if not strNuTempBoard:
            bLoopFlag = False

        if strNuTempBoard == strTempBoard:
            bLoopFlag = False
            
        strTempBoard = strNuTempBoard

print (nCount if not strTempBoard else -1)
