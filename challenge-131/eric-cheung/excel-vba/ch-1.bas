Attribute VB_Name = "ModTask_01"
Option Explicit
Option Base 1
Public Const strMyTitle As String = "Eric Cheung"

Sub Task_01()

    ''Const nMaxSize As Integer = 7 ''Example 1
    ''Const nMaxSize As Integer = 6 ''Example 2
    ''Const nMaxSize As Integer = 4 ''Example 3
    Const nMaxSize As Integer = 5 ''Example 4

    Dim strMsg As String
    Dim nArr(1 To nMaxSize) As Integer
    Dim nMatrix(1 To nMaxSize, 1 To nMaxSize) As Integer
    Dim nRowLoop As Integer, nColLoop As Integer, nLoop As Integer
    
    ''nArr(1) = 1: nArr(2) = 2: nArr(3) = 3: nArr(4) = 6: nArr(5) = 7: nArr(6) = 8: nArr(7) = 9 ''Example 1
    ''nArr(1) = 11: nArr(2) = 12: nArr(3) = 14: nArr(4) = 17: nArr(5) = 18: nArr(6) = 19 ''Example 2
    ''nArr(1) = 2: nArr(2) = 4: nArr(3) = 6: nArr(4) = 8 ''Example 3
    nArr(1) = 1: nArr(2) = 2: nArr(3) = 3: nArr(4) = 4: nArr(5) = 5 ''Example 4
    
    nRowLoop = 1
    nColLoop = 1
    
    For nLoop = 1 To nMaxSize
        If nLoop > 1 Then
            If nArr(nLoop) - nArr(nLoop - 1) = 1 Then
                nColLoop = nColLoop + 1
            Else
                nRowLoop = nRowLoop + 1
                nColLoop = 1
            End If
        End If
        nMatrix(nRowLoop, nColLoop) = nArr(nLoop)
    Next nLoop
    
    For nRowLoop = 1 To nMaxSize
        If nMatrix(nRowLoop, 1) > 0 Then
            If strMsg <> "" Then
                strMsg = strMsg & vbNewLine
            End If
            For nColLoop = 1 To nMaxSize
                If nMatrix(nRowLoop, nColLoop) > 0 Then
                    If nColLoop > 1 Then
                        strMsg = strMsg & ", "
                    End If
                    strMsg = strMsg & nMatrix(nRowLoop, nColLoop)
                End If
            Next nColLoop
        End If
    Next nRowLoop

    MsgBox strMsg, vbOKOnly, strMyTitle
    
End Sub
