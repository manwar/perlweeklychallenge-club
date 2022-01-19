Attribute VB_Name = "ModTask_02"
Option Explicit
Public nNumArr() As Integer

Function IsUniqComb(nInput As Integer) As Boolean
    
    Dim nSubLoop_01 As Integer, nSubLoop_02 As Integer
    Dim bOccur As Boolean
    
    bOccur = False
    IsUniqComb = True
    
    For nSubLoop_01 = LBound(nNumArr) To UBound(nNumArr) - 1
        For nSubLoop_02 = nSubLoop_01 + 1 To UBound(nNumArr)
            If nNumArr(nSubLoop_01) + nNumArr(nSubLoop_02) = nInput Then
                If Not bOccur Then
                    bOccur = True
                Else
                    IsUniqComb = False
                    Exit Function
                End If
            End If
        Next nSubLoop_02
    Next nSubLoop_01
    
End Function

Sub Task_02()

    '' Example 1
    '' Const nNum_01 As Integer = 1
    '' Const nNum_02 As Integer = 2
    
    '' Example 2
    '' Const nNum_01 As Integer = 2
    '' Const nNum_02 As Integer = 3
    
    '' Example 3
    Const nNum_01 As Integer = 2
    Const nNum_02 As Integer = 5
    
    Const nNumMax As Integer = 10
    
    Dim strMsg As String
    
    Dim nLoop_01 As Integer, nLoop_02 As Integer, nLoopCnt As Integer
    Dim nLastNum As Integer, nTempNum As Integer
    
    ReDim nNumArr(1 To 3)
    
    nNumArr(1) = nNum_01: nNumArr(2) = nNum_02: nNumArr(3) = nNum_01 + nNum_02: nLastNum = nNumArr(3)
    
    nLoopCnt = 3
    
    Do While (nLoopCnt < nNumMax)

        nTempNum = 9999
        For nLoop_01 = LBound(nNumArr) To UBound(nNumArr) - 1
            For nLoop_02 = nLoop_01 + 1 To UBound(nNumArr)
                If _
                    nNumArr(nLoop_01) + nNumArr(nLoop_02) > nLastNum _
                    And nNumArr(nLoop_01) + nNumArr(nLoop_02) < nTempNum _
                Then
                    nTempNum = nNumArr(nLoop_01) + nNumArr(nLoop_02)
                End If
            Next nLoop_02
        Next nLoop_01
        
        If IsUniqComb(nTempNum) Then
            nLoopCnt = nLoopCnt + 1
            ReDim Preserve nNumArr(1 To nLoopCnt)
            nNumArr(nLoopCnt) = nTempNum
        End If

        nLastNum = nTempNum
    Loop
    
    For nLoop_01 = LBound(nNumArr) To UBound(nNumArr)
        If strMsg <> "" Then
            strMsg = strMsg & ", "
        End If
        strMsg = strMsg & nNumArr(nLoop_01)
    Next nLoop_01
    
    MsgBox strMsg, vbOKOnly, strMyTitle
    
End Sub
