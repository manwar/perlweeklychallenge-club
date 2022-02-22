Attribute VB_Name = "ModTask_01"
Option Explicit

Public Const strMyTitle As String = "Eric Cheung"

Function GetLeftFact(ByVal nNum As Integer) As Long

    Dim nProd As Long, nSubLoop As Integer
    
    If nNum <= 0 Then
        GetLeftFact = 0
        Exit Function
    End If
    
    nProd = 1
    For nSubLoop = 1 To nNum
        GetLeftFact = GetLeftFact + nProd
        nProd = nProd * nSubLoop
    Next nSubLoop

End Function

Sub Task_01()

    Dim strMsg As String
    Dim nLoop As Integer
    
    For nLoop = 1 To 10
        If strMsg <> "" Then
            strMsg = strMsg & ", "
        End If
        strMsg = strMsg & GetLeftFact(nLoop)
    Next nLoop

    MsgBox strMsg, vbOKOnly, strMyTitle

End Sub
