Attribute VB_Name = "ModTask_01"
Option Explicit
Public Const strMyTitle As String = "Eric Cheung"

Function OddEvenSwap(nNum) As Integer

    Dim strBin As String, strNuBin As String
    Dim strTemp As String, strNuTemp As String
    Dim nLoop As Integer
    
    strBin = Format(Application.WorksheetFunction.Dec2Bin(nNum), "00000000")
    
    For nLoop = 0 To 3
        strTemp = Mid(strBin, 2 * nLoop + 1, 2)
        strNuTemp = strTemp
        
        If strTemp = "01" Then
            strNuTemp = "10"
        ElseIf strTemp = "10" Then
            strNuTemp = "01"
        End If
        
        strNuBin = strNuBin & strNuTemp
    Next nLoop
    
    OddEvenSwap = Application.WorksheetFunction.Bin2Dec(strNuBin)

End Function

Sub Task_01()

    Dim varInputNum
    
    Do
        varInputNum = InputBox("Please enter a number between 1 to 255", strMyTitle, 101)
        If varInputNum = "" Then Exit Sub
    Loop Until varInputNum > 0 And varInputNum < 256
    
    MsgBox "The answer for odd even bit position swap of " & varInputNum & " is: " & OddEvenSwap(varInputNum)
    
End Sub
