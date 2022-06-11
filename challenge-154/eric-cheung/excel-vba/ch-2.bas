Attribute VB_Name = "ModTask_02"
'''Option Explicit

'''Sub Task_02()
'''
'''    Dim strMsg As String
'''    strMsg = "2, 3, 5, 7, 37, 151, 3329, 23833, 13091204281, 3093215881333057"
'''
'''    MsgBox strMsg, vbOKOnly, strMyTitle
'''End Sub

Option Explicit

Function IsPrime(strInput As String) As Boolean
    
    Dim nNumLoop As Long
    
    For nNumLoop = 2 To Sqr(Val(strInput))
        If Val(strInput) Mod nNumLoop = 0 Then
            IsPrime = False
            Exit Function
        End If
    Next nNumLoop
    
    IsPrime = True
    
End Function

Sub Task_02()

    Dim strMsg As String
    Dim nCount As Integer
    Dim strLast As String, strLast_01 As String, strLast_02 As String
    
    strMsg = "2"
    nCount = 1
    
    strLast_02 = "1"
    strLast_01 = "2"

    Do While (nCount <= 10)
        
        strLast = CStr(Val(strLast_01) + CStr(strLast_02))
        
        If IsPrime(strLast) Then
            strMsg = strMsg & ", " & strLast
            nCount = nCount + 1
        End If
        
        strLast_02 = strLast_01
        strLast_01 = strLast
    Loop

    MsgBox strMsg, vbOKOnly, strMyTitle
    
End Sub

