Attribute VB_Name = "ModTask_02"
Option Explicit
Option Base 1

Function PrintArr(nMatrix, Optional bHide As Boolean = True) As String

    Dim nRowLoop As Integer, nColLoop As Integer
    
    For nRowLoop = LBound(nMatrix, 1) To UBound(nMatrix, 1)
        For nColLoop = LBound(nMatrix, 2) To UBound(nMatrix, 2)
            If PrintArr <> "" Then
                PrintArr = PrintArr & "  "
            End If
            
            If bHide And nMatrix(nRowLoop, nColLoop) = 0 Then
                PrintArr = PrintArr & "*"
            ElseIf nMatrix(nRowLoop, nColLoop) = -1 Then
                PrintArr = PrintArr & "x"
            Else
                PrintArr = PrintArr & nMatrix(nRowLoop, nColLoop)
            End If
        Next nColLoop
        PrintArr = PrintArr & vbNewLine
    Next nRowLoop

End Function

Function CountLandMineNearBy(ByRef nMatrix, nRowIndex As Integer, nColIndex As Integer) As Integer

    Dim nRowSize As Integer, nColSize As Integer
    
    If nMatrix(nRowIndex, nColIndex) = -1 Then
        CountLandMineNearBy = -1
        Exit Function
    End If
    
    nRowSize = UBound(nMatrix, 1) - LBound(nMatrix, 1) + 1
    nColSize = UBound(nMatrix, 2) - LBound(nMatrix, 2) + 1
    
    If nRowIndex - 1 > 0 And nColIndex - 1 > 0 Then
        If nMatrix(nRowIndex - 1, nColIndex - 1) = -1 Then
            CountLandMineNearBy = CountLandMineNearBy + 1
        End If
    End If
    
    If nRowIndex - 1 > 0 Then
        If nMatrix(nRowIndex - 1, nColIndex) = -1 Then
            CountLandMineNearBy = CountLandMineNearBy + 1
        End If
    End If
    
    If nRowIndex - 1 > 0 And nColIndex < nColSize Then
        If nMatrix(nRowIndex - 1, nColIndex + 1) = -1 Then
            CountLandMineNearBy = CountLandMineNearBy + 1
        End If
    End If
    
    If nColIndex - 1 > 0 Then
        If nMatrix(nRowIndex, nColIndex - 1) = -1 Then
            CountLandMineNearBy = CountLandMineNearBy + 1
        End If
    End If
    
    If nColIndex < nColSize Then
        If nMatrix(nRowIndex, nColIndex + 1) = -1 Then
            CountLandMineNearBy = CountLandMineNearBy + 1
        End If
    End If
    
    If nRowIndex < nRowSize And nColIndex - 1 > 0 Then
        If nMatrix(nRowIndex + 1, nColIndex - 1) = -1 Then
            CountLandMineNearBy = CountLandMineNearBy + 1
        End If
    End If
    
    If nRowIndex < nRowSize Then
        If nMatrix(nRowIndex + 1, nColIndex) = -1 Then
            CountLandMineNearBy = CountLandMineNearBy + 1
        End If
    End If
    
    If nRowIndex < nRowSize And nColIndex < nColSize Then
        If nMatrix(nRowIndex + 1, nColIndex + 1) = -1 Then
            CountLandMineNearBy = CountLandMineNearBy + 1
        End If
    End If
    
End Function

Sub CountLandMineNearByAll(ByRef nMatrix)
    
    Dim nRowLoop As Integer, nColLoop As Integer
    
    For nRowLoop = LBound(nMatrix, 1) To UBound(nMatrix, 1)
        For nColLoop = LBound(nMatrix, 2) To UBound(nMatrix, 2)
            If nMatrix(nRowLoop, nColLoop) > -1 Then
                nMatrix(nRowLoop, nColLoop) = CountLandMineNearBy(nMatrix, nRowLoop, nColLoop)
            End If
        Next nColLoop
    Next nRowLoop
    
End Sub

Sub Task_02()
    
    Const nRowNum As Integer = 5
    Const nColNum As Integer = 10
    
    Dim strMsg As String
    
    '' Define Rectangle
    Dim nMineArr(1 To nRowNum, 1 To nColNum) As Integer
    
    '' ======== Land Mine ========
    '' Initialize, -1 Represents Land Mine
    nMineArr(1, 1) = -1
    nMineArr(5, 1) = -1
    
    nMineArr(4, 4) = -1
    
    nMineArr(1, 5) = -1
    nMineArr(3, 5) = -1
    nMineArr(4, 5) = -1
    nMineArr(5, 5) = -1
    
    nMineArr(1, 7) = -1
    nMineArr(3, 7) = -1
    
    nMineArr(1, 8) = -1
    
    nMineArr(1, 9) = -1
    nMineArr(3, 9) = -1
    
    nMineArr(1, 10) = -1
    nMineArr(2, 10) = -1
    nMineArr(5, 10) = -1
    '' ======== Land Mine ========
    
    
    '' ======== Print Original Array ========
    ''strMsg = PrintArr(nMineArr)
    '' ======== Print Original Array ========
    
    '' ======== Count ========
    CountLandMineNearByAll nMineArr
    '' ======== Count ========
    
    '' ======== Print Count Array ========
    strMsg = PrintArr(nMineArr, False)
    '' ======== Print Count Array ========
    
    '' ======== Output Result ========
    MsgBox strMsg, vbOKOnly, strMyTitle
    '' ======== Output Result ========
    
End Sub

