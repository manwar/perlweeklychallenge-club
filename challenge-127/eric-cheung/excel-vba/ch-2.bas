Attribute VB_Name = "ModTask_02"
Option Explicit
Option Base 1

Sub Task_02()

    Const nSetInt As Integer = 5

    Dim nArrInterval(1 To nSetInt, 1 To 2) As Integer
    Dim nArrConInterval() As Integer
    Dim nX As Integer, nY As Integer, nCnt As Integer
    Dim strMsg As String
    
    ReDim nArrConInterval(1 To 2, 1 To 1)
    
    ''Initialize: (1,4), (3,5), (6,8), (12, 13), (3,20)
''    nArrInterval(1, 1) = 1: nArrInterval(1, 2) = 4
''    nArrInterval(2, 1) = 3: nArrInterval(2, 2) = 5
''    nArrInterval(3, 1) = 6: nArrInterval(3, 2) = 8
''    nArrInterval(4, 1) = 12: nArrInterval(4, 2) = 13
''    nArrInterval(5, 1) = 3: nArrInterval(5, 2) = 20
    
    ''Initialize: (3,4), (5,7), (6,9), (10, 12), (13,15)
    nArrInterval(1, 1) = 3: nArrInterval(1, 2) = 4
    nArrInterval(2, 1) = 5: nArrInterval(2, 2) = 7
    nArrInterval(3, 1) = 6: nArrInterval(3, 2) = 9
    nArrInterval(4, 1) = 10: nArrInterval(4, 2) = 12
    nArrInterval(5, 1) = 13: nArrInterval(5, 2) = 15
    
    nCnt = 0
    
    For nX = 2 To nSetInt
        For nY = 1 To nX - 1
            If _
                nArrInterval(nY, 1) <= nArrInterval(nX, 1) _
                And nArrInterval(nY, 2) >= nArrInterval(nX, 1) _
            Then
                nCnt = nCnt + 1
                If nCnt > 1 Then
                    ReDim Preserve nArrConInterval(1 To 2, 1 To nCnt)
                End If
                nArrConInterval(1, nCnt) = nArrInterval(nX, 1)
                nArrConInterval(2, nCnt) = nArrInterval(nX, 2)
                Exit For
            End If
        Next nY
    Next nX
    
    If nCnt > 0 Then
        strMsg = strMsg & "Conflict Intervals: ["
        For nX = 1 To nCnt
            If nX > 1 Then
                strMsg = strMsg & ", "
            End If
            strMsg = strMsg & "(" & nArrConInterval(1, nX) & ", " & nArrConInterval(2, nX) & ")"
        Next nX
        strMsg = strMsg & "]"
    Else
        strMsg = "No Conflict Intervals"
    End If

    '' ======== Output Result ========
    MsgBox strMsg, vbOKOnly, strMyTitle
    '' ======== Output Result ========
    
End Sub

