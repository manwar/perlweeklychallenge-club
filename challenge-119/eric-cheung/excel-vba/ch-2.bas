Attribute VB_Name = "ModTask_02"
Option Explicit
Option Base 1

Function GetSeqNum(nTerm) As Long
    Dim nLoop As Long, nSubLoop As Long, nCntItem As Long, nArrItemCnt As Long
    Dim nNumArr As Variant
    Dim nTmpArr() As Long, nNuTmpArr() As Long
    Dim bFlag As Boolean
    
    If nTerm < 1 Then
        GetSeqNum = 0
        Exit Function
    ElseIf nTerm <= 3 Then
        GetSeqNum = nTerm
        Exit Function
    End If
    
    nCntItem = 3
    nNumArr = Array(1, 2, 3)
    
    ReDim nTmpArr(1 To 3)
    For nLoop = 1 To 3
        nTmpArr(nLoop) = nLoop
    Next nLoop

    Do While True
        Erase nNuTmpArr
        bFlag = True
        
        For nLoop = LBound(nNumArr) To UBound(nNumArr)
            For nSubLoop = LBound(nTmpArr) To UBound(nTmpArr)
                If nNumArr(nLoop) > 1 Or Int(Left(nTmpArr(nSubLoop), 1)) > 1 Then
                    If bFlag Then
                        nArrItemCnt = 0
                        bFlag = False
                    Else
                        nArrItemCnt = UBound(nNuTmpArr) - LBound(nNuTmpArr) + 1
                    End If
                    
                    ReDim Preserve nNuTmpArr(1 To nArrItemCnt + 1)
                    nNuTmpArr(nArrItemCnt + 1) = Val(Str(nNumArr(nLoop)) & Str(nTmpArr(nSubLoop)))
                    nCntItem = nCntItem + 1
                    If nTerm = nCntItem Then
                        GetSeqNum = nNuTmpArr(nArrItemCnt + 1)
                        Exit Function
                    End If
                End If
            Next nSubLoop
        Next nLoop
        
        Erase nTmpArr
        nTmpArr = nNuTmpArr
    Loop

End Function

Sub Task_02()

    Dim varInputNum
    
    Do
        varInputNum = InputBox("Please enter a positive number for the term of the sequence", strMyTitle, 60)
        If varInputNum = "" Then Exit Sub
    Loop Until varInputNum > 0
    
    MsgBox "The answer for the " & varInputNum & "th term of the sequence is: " & GetSeqNum(varInputNum)
    
End Sub
