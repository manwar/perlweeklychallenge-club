Attribute VB_Name = "ModTask_01"
Option Explicit
Option Base 1
Public Const strMyTitle As String = "Eric Cheung"

Function RunningAvg()

    Dim arrNum
    Dim nArrCnt As Integer, nLoop As Integer
    Dim dSum As Double
    Dim dRunAvgArr() As Double

    arrNum = Array(10, 20, 30, 40, 50, 60, 70, 80, 90)
    
    nArrCnt = UBound(arrNum) - LBound(arrNum) + 1
    ReDim dRunAvgArr(1 To nArrCnt)
    
    For nLoop = 1 To nArrCnt
        dSum = dSum + arrNum(nLoop)
        dRunAvgArr(nLoop) = dSum / nLoop
    Next nLoop
    
    RunningAvg = dRunAvgArr

End Function

Sub Task_01()

    Dim dRunAvgList
    Dim strMsg As String
    Dim nCnt As Integer
    
    dRunAvgList = RunningAvg()
    
    strMsg = ""
    
    For nCnt = LBound(dRunAvgList) To UBound(dRunAvgList)
        If strMsg <> "" Then
            strMsg = strMsg & "; "
        End If
        strMsg = strMsg & dRunAvgList(nCnt)
    Next nCnt
    
    strMsg = "The Running Average List: " & vbNewLine & strMsg
    
    MsgBox strMsg, vbOKOnly, strMyTitle
    
End Sub
