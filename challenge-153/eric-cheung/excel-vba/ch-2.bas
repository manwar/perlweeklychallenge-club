Attribute VB_Name = "ModTask_02"
Option Explicit

Function IsFactorion(ByVal nNum As Integer) As Boolean

    Dim nSum As Integer, nLoop As Integer
    
    For nLoop = 1 To Len(CStr(nNum))
        nSum = nSum + Application.WorksheetFunction.Fact(Val(Mid(CStr(nNum), nLoop, 1)))
    Next nLoop
    
    If nSum = nNum Then
        IsFactorion = True
    Else
        IsFactorion = False
    End If

End Function

Sub Task_02()

    '' Const nNumInput As Integer = 145 '' Example 1:
    Const nNumInput As Integer = 123 '' Example 2:

    Dim strMsg As String
    
    If IsFactorion(nNumInput) Then
        strMsg = "1"
    Else
        strMsg = "0"
    End If

    MsgBox strMsg, vbOKOnly, strMyTitle
    
End Sub
