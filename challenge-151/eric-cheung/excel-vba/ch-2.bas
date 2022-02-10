Attribute VB_Name = "ModTask_02"
Option Explicit
Option Base 1

Public Const strMyTitle As String = "Eric Cheung"

Sub Task_02()

    Dim nRobValArr() As Variant
    Dim nRobArrCnt As Integer
    
    Dim nElemArr() As Integer
    Dim nElemArrCnt As Integer, nElemLoop As Integer, nElemSubLoop As Integer

    Dim dSumGain As Integer, dSumSubGain As Integer

    '' nRobValArr = Array(2, 4, 5) '' Example 1:
    nRobValArr = Array(4, 2, 3, 6, 5, 3) '' Example 2:

    nRobArrCnt = UBound(nRobValArr) - LBound(nRobValArr) + 1
    
    If nRobArrCnt Mod 2 = 0 Then
        nElemArrCnt = nRobArrCnt / 2
    Else
        nElemArrCnt = (nRobArrCnt + 1) / 2
    End If
    
    ReDim nElemArr(1 To nElemArrCnt)
    
    nElemLoop = 1
    nElemArr(1) = 1
    
    dSumGain = 0
    
    Do
        Do While nElemArr(nElemLoop) <= nRobArrCnt
            Do While nElemLoop < nElemArrCnt
                nElemLoop = nElemLoop + 1
                nElemArr(nElemLoop) = nElemArr(nElemLoop - 1) + 2
            Loop
            
            dSumSubGain = 0
            For nElemSubLoop = 1 To nElemArrCnt
                If nElemArr(nElemSubLoop) <= nRobArrCnt Then
                    dSumSubGain = dSumSubGain + nRobValArr(nElemArr(nElemSubLoop))
                End If
            Next nElemSubLoop
            
            If dSumSubGain > dSumGain Then
                dSumGain = dSumSubGain
            End If

            nElemArr(nElemLoop) = nElemArr(nElemLoop) + 1
        Loop
        
        nElemLoop = nElemLoop - 1
        nElemArr(nElemLoop) = nElemArr(nElemLoop) + 1
        
    Loop Until nElemArr(1) > nRobArrCnt
    
    MsgBox dSumGain, vbOKOnly, strMyTitle
    
End Sub
