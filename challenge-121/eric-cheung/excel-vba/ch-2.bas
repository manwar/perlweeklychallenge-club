Attribute VB_Name = "ModTask_02"
Option Explicit

Function GetMatrixPath(RngFill As Range, ByRef nMinCost As Integer)

    Dim nMatrixSize As Integer, nCntLoop As Integer
    Dim nSubLoop As Integer, nCheckLoop As Integer
    Dim nArrCnt() As Integer, nArrPath() As Integer
    Dim bArrTempUsed() As Boolean, bArrCheck() As Boolean
    Dim nCost As Integer
    Dim bPathValid As Boolean, bFirstPath As Boolean
    Dim nLastPos As Integer
    
    nMatrixSize = RngFill.Rows.Count
    
    ReDim nArrCnt(1 To nMatrixSize)
    ReDim nArrPath(1 To nMatrixSize)
    ReDim bArrTempUsed(1 To nMatrixSize)
    ReDim bArrCheck(1 To nMatrixSize)
    
    'Initialize
    nArrCnt(1) = 1
    
    bFirstPath = True
    nMinCost = 0
    
    '''Loop
    nCntLoop = 1
    Do
        Do While nArrCnt(nCntLoop) <= nMatrixSize
            Do While nCntLoop < nMatrixSize
                nCntLoop = nCntLoop + 1
                nArrCnt(nCntLoop) = 1
            Loop
            
            '' ===== Check Path Is Valid =====
            bPathValid = True
            For nSubLoop = 1 To nMatrixSize
                bArrTempUsed(nSubLoop) = False
            Next nSubLoop
            
            For nSubLoop = 1 To nMatrixSize
                If bArrTempUsed(nArrCnt(nSubLoop)) Then
                    bPathValid = False
                    Exit For
                Else
                    bArrTempUsed(nArrCnt(nSubLoop)) = True
                End If
            Next nSubLoop
            '' ===== Check Path Is Valid =====
            
            If bPathValid Then
                nCost = 0
                nLastPos = nArrCnt(1)
                For nSubLoop = 1 To nMatrixSize
                    If nSubLoop = nMatrixSize Then
                        nCost = nCost + RngFill(nLastPos, nArrCnt(1))
                    Else
                        nCost = nCost + RngFill(nLastPos, nArrCnt(nSubLoop + 1))
                        nLastPos = nArrCnt(nSubLoop + 1)
                    End If
                Next nSubLoop
                
                If bFirstPath Or nCost < nMinCost Then
                    For nSubLoop = 1 To nMatrixSize
                        nArrPath(nSubLoop) = nArrCnt(nSubLoop)
                    Next nSubLoop
                    nMinCost = nCost
                    bFirstPath = False
                End If
            End If

            nArrCnt(nCntLoop) = nArrCnt(nCntLoop) + 1
        Loop
        
        nCntLoop = nCntLoop - 1
        nArrCnt(nCntLoop) = nArrCnt(nCntLoop) + 1
        
    Loop Until nArrCnt(1) > nMatrixSize
    
    GetMatrixPath = nArrPath

End Function

Private Sub Task_02_Func(rngToCheck As Range)
    
    Dim arrResult
    Dim nPathCost As Integer, nLoop As Integer
    Dim strTourPath As String
    
    If rngToCheck.Rows.Count <> rngToCheck.Columns.Count Then
        Exit Sub
    End If

    arrResult = GetMatrixPath(rngToCheck, nPathCost)
    
    For nLoop = LBound(arrResult) To UBound(arrResult)
        If strTourPath <> "" Then
            strTourPath = strTourPath & ", "
        End If
        strTourPath = strTourPath & Format(arrResult(nLoop) - 1, "0")
    Next nLoop
    
    strTourPath = strTourPath & ", " & Format(arrResult(1) - 1, "0")
    strTourPath = "Min Cost: " & nPathCost & ", " & "Tour: " & strTourPath
    
    MsgBox strTourPath
    
End Sub

Private Sub Task_02_GenTable(nNum)

    Dim nLoop_01 As Integer, nLoop_02 As Integer
    Dim rngPos As Range
    
    Set rngPos = Range("B9")
    
    For nLoop_01 = 1 To nNum
        With rngPos.Offset(nLoop_01, 0)
            .Value = nLoop_01 - 1
            .HorizontalAlignment = xlCenter
        End With
        
        With rngPos.Offset(0, nLoop_01)
            .Value = nLoop_01 - 1
            .HorizontalAlignment = xlCenter
        End With
    
        For nLoop_02 = 1 To nNum
            With rngPos.Offset(nLoop_01, nLoop_02)
                .Value = Int((8 - 1 + 1) * Rnd + 1)
                .HorizontalAlignment = xlCenter
            End With
        Next nLoop_02
    Next nLoop_01
    
    Task_02_Func Range(rngPos.Offset(1, 1), rngPos.Offset(nNum, nNum))
    
End Sub

Sub Task_02()
    Task_02_Func Range("Rng_Task02")
End Sub

Sub Task_02_Bonus_1()

    Dim varInputNum
    
    Do
        varInputNum = InputBox("Please enter a number", strMyTitle, 5)
        If varInputNum = "" Then Exit Sub
    Loop Until varInputNum > 1
    
    Task_02_GenTable varInputNum

End Sub

Sub Task_02_Bonus_2()

    Dim varInputNum
    
    Do
        varInputNum = InputBox("Please enter either 12 or 15", strMyTitle, 12)
        If varInputNum = "" Then Exit Sub
    Loop Until varInputNum = 12 Or varInputNum = 15
    
    Task_02_GenTable varInputNum

End Sub

