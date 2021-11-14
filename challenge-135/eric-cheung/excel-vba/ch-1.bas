Attribute VB_Name = "ModTask_01"
Option Explicit

Public Const strMyTitle As String = "Eric Cheung"

Function GetMiddleThreeStr(ByVal nInputNum As Long) As String
    
    Dim strTempNum As String, nNumLen As Integer
    
    If nInputNum > 0 Then
        strTempNum = CStr(nInputNum)
    Else
        strTempNum = CStr(-nInputNum)
    End If
    
    nNumLen = Len(strTempNum)
    
    If nNumLen = 1 Then
        GetMiddleThreeStr = "Too Short"
        Exit Function
    End If
    
    If nNumLen Mod 2 = 0 Then
        GetMiddleThreeStr = "Even number of digits"
        Exit Function
    End If
    
    GetMiddleThreeStr = Mid(strTempNum, (nNumLen - 1) / 2, 3)

End Function

Sub Task_01()
    
    Dim strMsg As String
    
    '' strMsg = GetMiddleThreeStr(1234567) '' Example: 1
    '' strMsg = GetMiddleThreeStr(-123) '' Example: 2
    '' strMsg = GetMiddleThreeStr(1) '' Example: 3
    strMsg = GetMiddleThreeStr(10) '' Example: 4
    
    MsgBox strMsg, vbOKOnly, strMyTitle
    
End Sub
