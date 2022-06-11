Attribute VB_Name = "ModTask_01"
Option Explicit

Public Const strMyTitle As String = "Eric Cheung"

Sub Task_01()

    Dim nArrInt() As Variant
    Dim strMsg As String
    
    Dim nLoop As Integer, nElemCount As Integer
    
    Dim nAMSum As Integer, nGMSum As Long
    Dim dHMSum As Double
    
    '' nArrInt = Array(1, 3, 5, 6, 9) '' Example 1:
    '' nArrInt = Array(2, 4, 6, 8, 10) '' Example 2:
    nArrInt = Array(1, 2, 3, 4, 5) '' Example 3:
    
    nElemCount = UBound(nArrInt) - LBound(nArrInt) + 1
    
    nAMSum = 0
    nGMSum = 1
    dHMSum = 0
    
    For nLoop = LBound(nArrInt) To UBound(nArrInt)
        nAMSum = nAMSum + nArrInt(nLoop)
        nGMSum = nGMSum * nArrInt(nLoop)
        dHMSum = dHMSum + 1 / nArrInt(nLoop)
    Next nLoop
    
    strMsg = "AM: " & Round(nAMSum / nElemCount, 1) _
    & ", GM: " & Round(nGMSum ^ (1 / nElemCount), 1) _
    & ", HM: " & Round(nElemCount / dHMSum, 1)
    
    MsgBox strMsg, vbOKOnly, strMyTitle
    
End Sub
