Attribute VB_Name = "ModTask_02"
Option Explicit

Function IsPrime(nInput As Integer) As Boolean

    Dim nLoop As Integer
    
    For nLoop = 2 To Int(Sqr(nInput))
        If nInput Mod nLoop = 0 Then
            IsPrime = False
            Exit Function
        End If
    Next nLoop
    
    IsPrime = True
    
End Function

Function FindPeriodPrime(nInput As Integer) As Integer

    Dim nTemp As Integer, nSubTemp As Integer, nLoop As Integer
    
    FindPeriodPrime = 0
    nTemp = 1
    
    For nLoop = 1 To nInput - 1
        nTemp = (10 * nTemp) Mod nInput
    Next nLoop
    
    nSubTemp = nTemp
    
    Do
        nTemp = (10 * nTemp) Mod nInput
        FindPeriodPrime = FindPeriodPrime + 1
    Loop While nSubTemp <> nTemp

End Function

Sub Task_02()

    '' Credit: https://rosettacode.org/wiki/Long_primes#Java
    
    Const nLongPrimeMaxCount As Integer = 5

    Dim strMsg As String
    Dim nLongPrimeLoopCnt As Integer
    Dim nPrimeLoop As Integer
    
    nLongPrimeLoopCnt = 0
    nPrimeLoop = 7 '' First Long Prime Number
    
    Do
        If IsPrime(nPrimeLoop) Then
            If FindPeriodPrime(nPrimeLoop) = nPrimeLoop - 1 Then
                If strMsg <> "" Then
                    strMsg = strMsg & ", "
                End If
                strMsg = strMsg & nPrimeLoop
                nLongPrimeLoopCnt = nLongPrimeLoopCnt + 1
            End If
        End If
        
        nPrimeLoop = nPrimeLoop + 2
    Loop While nLongPrimeLoopCnt < nLongPrimeMaxCount
    
    strMsg = "First " & nLongPrimeMaxCount & " Long Primes are: " & strMsg

    MsgBox strMsg, vbOKOnly, strMyTitle
    
End Sub
