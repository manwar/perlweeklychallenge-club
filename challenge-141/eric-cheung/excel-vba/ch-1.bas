Attribute VB_Name = "ModTask_01"
Option Explicit

Public Const strMyTitle As String = "Eric Cheung"

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

Function CountNumFactor() As Integer

    Dim nNumLoop As Integer
    CountNumFactor = 1
    
    For nNumLoop = LBound(nPrimePow) To UBound(nPrimePow)
        CountNumFactor = CountNumFactor * (nPrimePow(nNumLoop) + 1)
    Next nNumLoop

End Function

Sub Task_01()

    Const nNumDiv As Integer = 8

    Dim strMsg As String
    Dim nLoop As Long, nCnt As Integer, nPrimeCnt As Long
    
    ReDim nPrimeArr(1 To 1)
    ReDim nPrimePow(1 To 1)
    
    nPrimeCnt = 1
    nPrimeArr(1) = 2
    
    nLoop = 3
    nCnt = 0

    Do While (nCnt < 10)
        If Not IsPrime(nLoop) Then
            If CountNumFactor() = nNumDiv Then
                If strMsg <> "" Then
                    strMsg = strMsg & ", "
                End If
                strMsg = strMsg & nLoop
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
    
    strMsg = "First 10 positive integers having exactly " & nNumDiv & " divisors are: " & strMsg

    MsgBox strMsg, vbOKOnly, strMyTitle
    
End Sub


