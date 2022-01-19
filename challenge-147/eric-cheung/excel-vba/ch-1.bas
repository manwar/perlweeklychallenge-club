Attribute VB_Name = "ModTask_01"
Option Explicit

Public Const strMyTitle As String = "Eric Cheung"

Option Base 1
Public nPrimeArr() As Long
Public nPrimeCnt As Integer

Function IsPrime(nInput As Integer) As Boolean

    Dim nNumLoop As Integer
    
    If nInput = 1 Then
        IsPrime = False
        Exit Function
    End If
    
    For nNumLoop = LBound(nPrimeArr) To UBound(nPrimeArr)
        If nInput = nPrimeArr(nNumLoop) Then
            IsPrime = True
            Exit Function
        ElseIf nInput Mod nPrimeArr(nNumLoop) = 0 Then
            IsPrime = False
            Exit Function
        End If
    Next nNumLoop

    IsPrime = True
    
End Function

Function IsTruncatablePrime(nInput As Integer) As Boolean

    If nInput = 0 Then
        IsTruncatablePrime = False
        Exit Function
    ElseIf Not IsPrime(nInput) Then
        IsTruncatablePrime = False
        Exit Function
    End If
    
    nPrimeCnt = nPrimeCnt + 1
    ReDim Preserve nPrimeArr(1 To nPrimeCnt)
    nPrimeArr(nPrimeCnt) = nInput
    
    If nInput < 10 Then
        IsTruncatablePrime = True
    Else
        If Val(Mid(CStr(nInput), 2, 1)) = 0 Then
            IsTruncatablePrime = False
            Exit Function
        End If
        IsTruncatablePrime = IsTruncatablePrime(Val(Right(CStr(nInput), Len(CStr(nInput)) - 1)))
    End If
    
End Function

Sub Task_01()

    Const nTruncatablePrimeCntMax As Integer = 20

    Dim nLoop As Integer, nTruncatablePrimeCnt As Integer
    Dim strMsg As String
    
    ReDim nPrimeArr(1 To 1)
    
    nPrimeCnt = 1
    nPrimeArr(1) = 2
    nLoop = 3
    
    nTruncatablePrimeCnt = 1
    
    strMsg = "First " & nTruncatablePrimeCntMax & " left-truncatable prime numbers in base 10 are: " & 2

    Do While (nTruncatablePrimeCnt < nTruncatablePrimeCntMax)
        If IsTruncatablePrime(nLoop) Then
            strMsg = strMsg & ", " & nLoop
            nTruncatablePrimeCnt = nTruncatablePrimeCnt + 1
        End If
        nLoop = nLoop + 1
    Loop

    MsgBox strMsg, vbOKOnly, strMyTitle

End Sub
