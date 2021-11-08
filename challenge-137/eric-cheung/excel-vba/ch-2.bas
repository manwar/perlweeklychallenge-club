Attribute VB_Name = "ModTask_02"
Option Explicit

Function IsPalindromeNum(ByVal strNumCheck As String) As Boolean

    IsPalindromeNum = False
    If strNumCheck = StrReverse(strNumCheck) Then
        IsPalindromeNum = True
    End If

End Function

Sub Task_02()

    '' Credit
    '' https://datagenetics.com/blog/october12015/index.html
    
    Const nInput As Integer = 56 '' Example 1
    '' Const nInput As Integer = 57 '' Example 2
    '' Const nInput As Integer = 59 '' Example 3

    Const nMaxLoop As Integer = 500

    Dim strMsg As String, strTemp As String
    Dim nLoop As Integer
    
    strTemp = CStr(nInput)
    strMsg = "1"
    
    For nLoop = 1 To nMaxLoop
    
        If Val(strTemp) > 10000000 Then
            Exit For
        End If
    
        If IsPalindromeNum(strTemp) Then
            strMsg = "0"
            Exit For
        End If
        
        strTemp = CStr(Val(strTemp) + Val(StrReverse(strTemp)))
        
    Next nLoop
    
    MsgBox strMsg, vbOKOnly, strMyTitle
    
End Sub
