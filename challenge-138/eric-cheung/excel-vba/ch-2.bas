Attribute VB_Name = "ModTask_02"
Option Explicit

Function splitStrFunc(strInput As String, nFirstCharPos As Integer, nStrLen As Integer)
    splitStrFunc = Mid(strInput, nFirstCharPos, nStrLen)
End Function

Sub Task_02()

    '' Const nPerSq As Integer = 81 '' Input Perfect Square: Example 1
    Const nPerSq As Integer = 9801 '' Input Perfect Square: Example 2
    Dim nSqrNum As Integer

    Dim strMsg As String, strSum As String
    
    nSqrNum = Sqr(nPerSq)
    
    strSum = CStr(Val(splitStrFunc(CStr(nPerSq), 1, Len(CStr(nSqrNum)))) + Val(splitStrFunc(CStr(nPerSq), Len(CStr(nSqrNum)) + 1, Len(CStr(nSqrNum)))))
    
    strMsg = "0"
    If CStr(nSqrNum) = strSum Then
        strMsg = "1"
    End If

    MsgBox strMsg, vbOKOnly, strMyTitle
    
End Sub
