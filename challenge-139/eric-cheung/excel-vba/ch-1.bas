Attribute VB_Name = "ModTask_01"
Option Explicit

Public Const strMyTitle As String = "Eric Cheung"

Sub Task_01()

    Dim strMsg As String
    Dim nArr() As Variant
    Dim nLoop As Integer
    Dim bSortFlag As Boolean, bAscOrder As Boolean
    
    bSortFlag = True
    
    '' nArr = Array(1, 2, 3, 4, 5) '' Example 1
    nArr = Array(1, 3, 2, 4, 5) '' Example 2
    
    If nArr(LBound(nArr)) < nArr(LBound(nArr) + 1) Then
        bAscOrder = True
    Else
        bAscOrder = False
    End If
    
    For nLoop = LBound(nArr) + 1 To UBound(nArr)
        If _
            bAscOrder And nArr(nLoop) < nArr(nLoop - 1) _
            Or Not bAscOrder And nArr(nLoop) > nArr(nLoop - 1) _
        Then
            bSortFlag = False
            Exit For
        End If
    Next nLoop
    
    strMsg = "0"
    If bSortFlag Then
        strMsg = "1"
    End If
    
    MsgBox strMsg, vbOKOnly, strMyTitle
    
End Sub
