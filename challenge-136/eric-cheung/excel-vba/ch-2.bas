Attribute VB_Name = "ModTask_02"
Option Explicit

Public arrFibonSeq() As Variant

Sub GenFibonSeq(ByVal nNum As Integer)

    Dim nLoop As Integer, nSum As Integer
    
    nLoop = 2
    ReDim arrFibonSeq(1 To nLoop)
    
    arrFibonSeq(1) = 1
    arrFibonSeq(2) = 2
    
    Do
        nSum = arrFibonSeq(nLoop) + arrFibonSeq(nLoop - 1)
        If nSum > nNum Then Exit Sub
        nLoop = nLoop + 1
        ReDim Preserve arrFibonSeq(1 To nLoop)
        arrFibonSeq(nLoop) = nSum
    Loop Until nSum > nNum

End Sub

Sub Task_02()

    '' Const nInput As Integer = 16 '' Example 1
    '' Const nInput As Integer = 9 '' Example 2
    Const nInput As Integer = 15 '' Example 3

    Dim nArrSize As Integer, nWayCount As Integer, nIndxLoop As Integer, nLastIndx As Integer, nLoopSum As Integer
    Dim bFlag As Boolean
    
    If _
        nInput = 1 _
        Or nInput = 2 _
    Then
        nWayCount = 1
    Else
        nWayCount = 0
    
        GenFibonSeq (nInput)
        nArrSize = UBound(arrFibonSeq) - LBound(arrFibonSeq) + 1
        
        nLastIndx = nArrSize
        
        Do While nLastIndx > 1
            nLoopSum = nInput
            For nIndxLoop = nLastIndx To 1 Step -1
                If nLoopSum >= arrFibonSeq(nIndxLoop) Then
                    bFlag = False
                    
                    If _
                        nLoopSum = arrFibonSeq(nIndxLoop) _
                        And nIndxLoop < nArrSize _
                        And nIndxLoop >= 3 _
                    Then
                        bFlag = True
                    End If
                    
                    nLoopSum = nLoopSum - arrFibonSeq(nIndxLoop)
                    
                    If nLoopSum = 0 Then
                        nWayCount = nWayCount + 1
                        If bFlag Then
                            nWayCount = nWayCount + 1
                        End If
                        Exit For
                    End If

                End If
            Next nIndxLoop
            
            nLastIndx = nLastIndx - 1
        Loop
    End If

    MsgBox nWayCount, vbOKOnly, strMyTitle

End Sub
