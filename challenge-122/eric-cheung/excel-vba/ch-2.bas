Attribute VB_Name = "ModTask_02"
Option Explicit

Function GetPntScore(nNum)

    Const nPntMax As Integer = 3
    Const nPntMin As Integer = 1

    Dim nCntLoop As Integer, nSubLoop As Integer, nTotalCnt As Integer
    Dim nSum As Integer
    
    Dim nArrCnt() As Integer, nArrMax() As Integer
    Dim nResultArr() As Integer
    
    ReDim nArrCnt(1 To nNum)
    ReDim nArrMax(1 To nNum)
    ReDim nResultArr(1 To nNum, 1 To 1)
    
    '''Initialize
    nCntLoop = 1
    nTotalCnt = 0
    
    nArrCnt(1) = nPntMin
    nArrMax(1) = nPntMax
    
    '''Loop
    Do
        Do While nArrCnt(nCntLoop) >= nPntMin And nArrCnt(nCntLoop) <= nArrMax(nCntLoop)
            Do While nCntLoop < nNum
                nCntLoop = nCntLoop + 1
                
                nSum = nNum
                For nSubLoop = 1 To nCntLoop - 1
                    nSum = nSum - nArrCnt(nSubLoop)
                Next nSubLoop
                
                nArrCnt(nCntLoop) = Application.Min(1, nSum)
                nArrMax(nCntLoop) = Application.Max(0, nSum)
            Loop
            
            nTotalCnt = nTotalCnt + 1
            If nTotalCnt > 1 Then
                ReDim Preserve nResultArr(1 To nNum, 1 To nTotalCnt)
            End If
            
            For nSubLoop = 1 To nNum
                nResultArr(nSubLoop, nTotalCnt) = nArrCnt(nSubLoop)
            Next nSubLoop
            
            nArrCnt(nCntLoop) = nArrCnt(nCntLoop) + 1
        Loop
        
        nCntLoop = nCntLoop - 1
        nArrCnt(nCntLoop) = nArrCnt(nCntLoop) + 1
        
    Loop Until nArrCnt(1) > nPntMax
    
    GetPntScore = nResultArr

End Function

Sub Task_02()

    Dim arrResult
    Dim nRowLoop As Integer, nColLoop As Integer
    Dim strMsg As String, strSubMsg As String
    
    Dim varInputNum
    
    Do
        varInputNum = InputBox("Please enter a number > 0", strMyTitle, 4)
        If varInputNum = "" Then Exit Sub
    Loop Until varInputNum > 0
    
    arrResult = GetPntScore(varInputNum)
    strMsg = ""
    
    For nRowLoop = LBound(arrResult, 2) To UBound(arrResult, 2)
        strSubMsg = ""
        For nColLoop = LBound(arrResult, 1) To UBound(arrResult, 1)
            If arrResult(nColLoop, nRowLoop) > 0 Then
                If strSubMsg <> "" Then
                    strSubMsg = strSubMsg & "; "
                End If
                strSubMsg = strSubMsg & arrResult(nColLoop, nRowLoop)
            End If
        Next nColLoop
        
        If strMsg <> "" Then
            strMsg = strMsg & vbNewLine
        End If
        strMsg = strMsg & strSubMsg
    Next nRowLoop
    
    strMsg = "The methods are: " & vbNewLine & strMsg
    
    MsgBox strMsg, vbOKOnly, strMyTitle
    
End Sub

