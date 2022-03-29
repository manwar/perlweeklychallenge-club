Attribute VB_Name = "ModTask_02"
Option Explicit

Function GetBaseSeq(ByVal nNum As Integer, ByVal nBase As Integer) As String
    
    Dim nQuot As Integer, nRemain As Integer
    
    nQuot = nNum
    Do While nQuot >= nBase
        nRemain = nQuot Mod nBase
        GetBaseSeq = nRemain & GetBaseSeq
        nQuot = Int(nQuot / nBase)
    Loop
    GetBaseSeq = nQuot & GetBaseSeq
    
End Function

Function IsSameDigit(ByVal strBaseSeq As String) As Boolean

    Dim nSubLoop As Integer
    Dim strChar As String
    
    strChar = Left(strBaseSeq, 1)
    
    For nSubLoop = 2 To Len(strBaseSeq)
        If strChar <> Mid(strBaseSeq, nSubLoop, 1) Then
            IsSameDigit = False
            Exit Function
        End If
    Next nSubLoop
    
    IsSameDigit = True
    
End Function

Sub Task_02()

    '' Const nInput As Integer = 7 '' Example 1:
    '' Const nInput As Integer = 6 '' Example 2:
    Const nInput As Integer = 8 '' Example 3:

    Dim strMsg As String
    Dim nLoop As Integer
    Dim bFlag As Boolean
    
    bFlag = False
    
    For nLoop = 2 To nInput - 2
        If IsSameDigit(GetBaseSeq(nInput, nLoop)) Then
            bFlag = True
            Exit For
        End If
    Next nLoop
    
    strMsg = "0"
    If bFlag Then
        strMsg = "1"
    End If

    MsgBox strMsg, vbOKOnly, strMyTitle
    
End Sub
