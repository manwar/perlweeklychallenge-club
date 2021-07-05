Attribute VB_Name = "ModTask_01"
Option Explicit
Public Const strMyTitle As String = "Eric Cheung"

Function GetSwapNibble(nNumToSwap) As Integer

    If nNumToSwap < 0 Or nNumToSwap > 255 Then
        GetSwapNibble = 0
        Exit Function
    End If
    
    Dim strOrigBin As String, strBin_01 As String, strBin_02 As String, strSwapBin As String
    strOrigBin = Application.WorksheetFunction.Dec2Bin(nNumToSwap)
    strBin_01 = Right(strOrigBin, 4)
    strBin_02 = Format(Val(Left(strOrigBin, Len(strOrigBin) - 4)), "0000")
    strSwapBin = strBin_01 & strBin_02
    GetSwapNibble = Application.WorksheetFunction.Bin2Dec(strSwapBin)
    
End Function

Sub Task_01()
    Dim varInputNum
    
    Do
        varInputNum = InputBox("Please enter a number between 1 to 255", strMyTitle, 101)
        If varInputNum = "" Then Exit Sub
    Loop Until varInputNum > 0 And varInputNum < 256
    
    MsgBox "The answer for swapped nibble of " & varInputNum & " is: " & GetSwapNibble(varInputNum)
End Sub
