Attribute VB_Name = "ModTask_01"
Option Explicit
Option Base 1
Public Const strMyTitle As String = "Eric Cheung"

''Public Const nRowNum As Integer = 3
''Public Const nColNum As Integer = 6

Public Const nRowNum As Integer = 3
Public Const nColNum As Integer = 4

Function bIsMatrixOne _
( _
    ByRef nMatrix, _
    nStartRowIndx As Integer, _
    nStartColIndx As Integer, _
    nEndRowIndx As Integer, _
    nEndColIndx As Integer _
) As Boolean
    
    Dim nRowSubLoop As Integer, nColSubLoop As Integer
    bIsMatrixOne = False
    
    For nRowSubLoop = nStartRowIndx To nEndRowIndx
        For nColSubLoop = nStartColIndx To nEndColIndx
            If nMatrix(nRowSubLoop, nColSubLoop) = 1 Then
                bIsMatrixOne = True
                Exit Function
            End If
        Next nColSubLoop
    Next nRowSubLoop
    
End Function

Sub Task_01()
    
    Dim nBinArr(1 To nRowNum, 1 To nColNum) As Integer
    Dim nRowLoop As Integer, nColLoop As Integer, nRowNestLoop As Integer, nColNestLoop As Integer
    Dim nRowZeroMax As Integer, nColZeroMax As Integer
    Dim nTempRowNum As Integer, nTempColNum As Integer
    Dim strMsg As String
    
    'Initialize
''    nBinArr(1, 1) = 1: nBinArr(1, 2) = 0: nBinArr(1, 3) = 0: nBinArr(1, 4) = 0: nBinArr(1, 3) = 1: nBinArr(1, 6) = 0
''    nBinArr(2, 1) = 1: nBinArr(2, 2) = 1: nBinArr(2, 3) = 0: nBinArr(2, 4) = 0: nBinArr(2, 3) = 0: nBinArr(2, 6) = 1
''    nBinArr(3, 1) = 1: nBinArr(3, 2) = 0: nBinArr(3, 3) = 0: nBinArr(3, 4) = 0: nBinArr(3, 3) = 0: nBinArr(3, 6) = 0
    
    nBinArr(1, 1) = 0: nBinArr(1, 2) = 0: nBinArr(1, 3) = 1: nBinArr(1, 4) = 1
    nBinArr(2, 1) = 0: nBinArr(2, 2) = 0: nBinArr(2, 3) = 0: nBinArr(2, 4) = 1
    nBinArr(3, 1) = 0: nBinArr(3, 2) = 0: nBinArr(3, 3) = 1: nBinArr(3, 4) = 0
    
    If Application.Sum(nBinArr) = nRowNum * nColNum Then
        'All 1
        nRowZeroMax = 0: nColZeroMax = 0
    Else
        nRowZeroMax = 1: nColZeroMax = 1
        
        For nRowLoop = 1 To nRowNum
            For nColLoop = 1 To nColNum
                If nBinArr(nRowLoop, nColLoop) = 0 Then
                    For nRowNestLoop = nRowLoop + 1 To nRowNum
                        For nColNestLoop = nColLoop + 1 To nColNum
                            If Not bIsMatrixOne(nBinArr, nRowLoop, nColLoop, nRowNestLoop, nColNestLoop) Then
                                nTempRowNum = nRowNestLoop - nRowLoop + 1
                                nTempColNum = nColNestLoop - nColLoop + 1
                                If nTempRowNum * nTempColNum > nRowZeroMax * nColZeroMax Then
                                    nRowZeroMax = nTempRowNum
                                    nColZeroMax = nTempColNum
                                End If
                            End If
                        Next nColNestLoop
                    Next nRowNestLoop
                End If
            Next nColLoop
        Next nRowLoop
    End If
    
    strMsg = "Max. SubMatrix having only : " & nRowZeroMax & " * " & nColZeroMax

    MsgBox strMsg, vbOKOnly, strMyTitle
    
End Sub
