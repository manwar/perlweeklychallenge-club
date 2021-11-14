Attribute VB_Name = "ModTask_02"
Option Explicit
Option Base 1
Public nPrimeArr() As Long
Public nPrimePow() As Long

Function IsPrime(nInput As Long) As Boolean

    Dim nNumLoop As Integer, nTempInt As Long
    Dim bFlag As Boolean
    
    bFlag = False

    For nNumLoop = LBound(nPrimeArr) To UBound(nPrimeArr)
        nPrimePow(nNumLoop) = 0
    Next nNumLoop
    
    nNumLoop = LBound(nPrimeArr)
    nTempInt = nInput
    
    Do While nNumLoop <= UBound(nPrimeArr)
        If nTempInt Mod nPrimeArr(nNumLoop) = 0 Then
            nTempInt = nTempInt / nPrimeArr(nNumLoop)
            nPrimePow(nNumLoop) = nPrimePow(nNumLoop) + 1
            bFlag = True
        Else
            nNumLoop = nNumLoop + 1
        End If
    Loop

    If bFlag Then
        IsPrime = False
    Else
        IsPrime = True
    End If
    
End Function

Function SumOfDigits(nInput As Long) As Integer

    Dim nTempNum As Long

    nTempNum = nInput
    Do While nTempNum > 0
        SumOfDigits = SumOfDigits + nTempNum Mod 10
        nTempNum = Int(nTempNum / 10)
    Loop

End Function

Function IsSmith(nInput As Long) As Boolean

    Dim nNum_01 As Integer, nNum_02 As Integer, nNumLoop As Integer
    
    nNum_01 = SumOfDigits(nInput)
    
    For nNumLoop = LBound(nPrimeArr) To UBound(nPrimeArr)
        nNum_02 = nNum_02 + SumOfDigits(nPrimeArr(nNumLoop)) * nPrimePow(nNumLoop)
    Next nNumLoop
    
    If nNum_01 = nNum_02 Then
        IsSmith = True
    Else
        IsSmith = False
    End If
    
End Function

Sub Task_02()

    Dim strMsg As String
    Dim nLoop As Long, nCnt As Integer, nPrimeCnt As Long
    
    ReDim nPrimeArr(1 To 1)
    ReDim nPrimePow(1 To 1)
    
    nPrimeCnt = 1
    nPrimeArr(1) = 2
    
    nLoop = 3
    nCnt = 0
    
    strMsg = "First 10 Smith Numbers in base 10 are "

    Do While (nCnt < 10)
        If Not IsPrime(nLoop) Then
            If IsSmith(nLoop) Then
                strMsg = strMsg & ", " & nLoop
                nCnt = nCnt + 1
            End If
        Else
            nPrimeCnt = nPrimeCnt + 1
            ReDim Preserve nPrimeArr(1 To nPrimeCnt)
            ReDim nPrimePow(1 To nPrimeCnt)
            nPrimeArr(nPrimeCnt) = nLoop
        End If
        nLoop = nLoop + 1
    Loop

    MsgBox strMsg, vbOKOnly, strMyTitle
    
End Sub

