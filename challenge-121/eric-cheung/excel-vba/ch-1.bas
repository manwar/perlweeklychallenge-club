Attribute VB_Name = "ModTask_01"
Option Explicit
Public Const strMyTitle As String = "Eric Cheung"

Function InvertBit(nNum, nPos) As Integer

    Dim strBin As String, strNuBin As String
    
    strBin = Format(Application.WorksheetFunction.Dec2Bin(nNum), "00000000")
    
    If nPos < 8 Then
        strNuBin = Left(strBin, 8 - nPos)
    End If
    
    strNuBin = strNuBin & Format(1 - Val(Left(Right(strBin, nPos), 1)), "0")
    
    If nPos > 1 Then
        strNuBin = strNuBin & Right(strBin, nPos - 1)
    End If
    
    InvertBit = Application.WorksheetFunction.Bin2Dec(strNuBin)

End Function

Sub Task_01()

    Dim varInputNum, varPosNum
    
    Do
        varInputNum = InputBox("Please enter a number between 1 to 255", strMyTitle, 12)
        If varInputNum = "" Then Exit Sub
        
        varPosNum = InputBox("Please enter a number between 1 to 8", strMyTitle, 3)
        If varPosNum = "" Then Exit Sub
        
    Loop Until varInputNum > 0 And varInputNum < 256 And varPosNum > 0 And varPosNum < 9
    
    MsgBox "The answer for inverting " & varPosNum & "th bit from the end of " & varInputNum & " is: " & InvertBit(varInputNum, varPosNum)
    
End Sub
