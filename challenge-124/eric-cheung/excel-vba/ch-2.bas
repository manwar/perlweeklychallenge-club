Attribute VB_Name = "ModTask_02"
Option Explicit
Option Base 1

Sub Task_02()

    Const nPntMin As Integer = 1

    Dim nArrSet As Variant
    Dim nCntLoop As Integer, nLoop As Integer, nSubLoop As Integer
    Dim nSubSetMaxLimit_01 As Integer, nSubSetMaxLimit_02 As Integer, nMaxLimit As Integer
    Dim nSetTotal As Integer, nSubSetTotal_01 As Integer, nSubSetTotal_02 As Integer
    Dim nSetAbsDiff As Integer, nSetLoopAbsDiff As Integer
    Dim bFlag As Boolean
    Dim wsFunc As Object
    Dim strMsg As String
    
    Dim nArrCnt() As Integer, nArrSet_01() As Integer, nArrSet_02() As Integer
    Dim bFlagArr() As Boolean
    
    Set wsFunc = Application.WorksheetFunction
    
    nArrSet = Array(10, 20, 30, 40, 50, 60, 70, 80, 90, 100)
    ''nArrSet = Array(10, -15, 20, 30, -25, 0, 5, 40, -5)
    
    nSetTotal = wsFunc.Sum(nArrSet)
    nSetAbsDiff = nSetTotal
    
    nMaxLimit = UBound(nArrSet) - LBound(nArrSet) + 1
    If nMaxLimit Mod 2 = 0 Then
        nSubSetMaxLimit_01 = nMaxLimit / 2
        nSubSetMaxLimit_02 = nMaxLimit / 2
    Else
        nSubSetMaxLimit_01 = (nMaxLimit - 1) / 2
        nSubSetMaxLimit_02 = (nMaxLimit + 1) / 2
    End If
    
    ReDim bFlagArr(1 To nMaxLimit)
    
    ReDim nArrCnt(1 To nSubSetMaxLimit_01)
    ReDim nArrSet_01(1 To nSubSetMaxLimit_01)
    ReDim nArrSet_02(1 To nSubSetMaxLimit_02)
    
    '''Initialize
    nCntLoop = 1
    
    nArrCnt(1) = nPntMin
    
    '''Loop
    Do
        Do While nArrCnt(nCntLoop) >= nPntMin And nArrCnt(nCntLoop) <= nMaxLimit
            Do While nCntLoop < nSubSetMaxLimit_01
                nCntLoop = nCntLoop + 1
                nArrCnt(nCntLoop) = nArrCnt(nCntLoop - 1) + 1
            Loop
            
            bFlag = True
            For nLoop = 1 To nSubSetMaxLimit_01
                If nArrCnt(nLoop) > nMaxLimit Then
                    bFlag = False
                    Exit For
                End If
            Next nLoop
            
            If bFlag Then
                For nLoop = 1 To nMaxLimit
                    bFlagArr(nLoop) = False
                Next nLoop
            
                nSubSetTotal_01 = 0
                For nLoop = 1 To nSubSetMaxLimit_01
                    nSubSetTotal_01 = nSubSetTotal_01 + nArrSet(nArrCnt(nLoop))
                Next nLoop

                nSubSetTotal_02 = nSetTotal - nSubSetTotal_01
                
                nSetLoopAbsDiff = Abs(nSubSetTotal_01 - nSubSetTotal_02)

                If nSetLoopAbsDiff < nSetAbsDiff Then
                    nSetAbsDiff = nSetLoopAbsDiff
                    For nLoop = 1 To nSubSetMaxLimit_01
                        nArrSet_01(nLoop) = nArrSet(nArrCnt(nLoop))
                        bFlagArr(nArrCnt(nLoop)) = True
                    Next nLoop
                    
                    nSubLoop = 1
                    For nLoop = 1 To nMaxLimit
                        If Not bFlagArr(nLoop) Then
                            nArrSet_02(nSubLoop) = nArrSet(nLoop)
                            nSubLoop = nSubLoop + 1
                        End If
                    Next nLoop
                End If
            End If
            
            nArrCnt(nCntLoop) = nArrCnt(nCntLoop) + 1
        Loop
        
        nCntLoop = nCntLoop - 1
        nArrCnt(nCntLoop) = nArrCnt(nCntLoop) + 1
        
    Loop Until nArrCnt(1) > nMaxLimit
    
    strMsg = "Output 1: "
    For nLoop = LBound(nArrSet_01) To UBound(nArrSet_01)
        If nLoop > LBound(nArrSet_01) Then
            strMsg = strMsg & ","
        End If
        strMsg = strMsg & " " & nArrSet_01(nLoop)
    Next nLoop
    
    strMsg = strMsg & vbNewLine
    strMsg = strMsg & "Output 2: "
    
    For nLoop = LBound(nArrSet_02) To UBound(nArrSet_02)
        If nLoop > LBound(nArrSet_02) Then
            strMsg = strMsg & ","
        End If
        strMsg = strMsg & " " & nArrSet_02(nLoop)
    Next nLoop
    
    MsgBox strMsg, vbOKOnly, strMyTitle
    
    Set wsFunc = Nothing

End Sub

