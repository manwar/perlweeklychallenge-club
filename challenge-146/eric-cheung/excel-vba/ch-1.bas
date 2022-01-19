Attribute VB_Name = "ModTask_01"
Option Explicit

Public Const strMyTitle As String = "Eric Cheung"

Option Base 1
Public nPrimeArr() As Long

Function IsPrime(nInput As Integer) As Boolean

    Dim nNumLoop As Integer
    
    For nNumLoop = LBound(nPrimeArr) To UBound(nPrimeArr)
        If nInput Mod nPrimeArr(nNumLoop) = 0 Then
            IsPrime = False
            Exit Function
        End If
    Next nNumLoop

    IsPrime = True
    
End Function

Sub Task_01()

    Const nPrimeCntMax As Integer = 10001

    Dim nLoop As Integer, nPrimeCnt As Integer
    
    ReDim nPrimeArr(1 To 1)
    
    nPrimeCnt = 1
    nPrimeArr(1) = 2
    nLoop = 3

    Do While (nPrimeCnt < nPrimeCntMax)
        If IsPrime(nLoop) Then
            nPrimeCnt = nPrimeCnt + 1
            ReDim Preserve nPrimeArr(1 To nPrimeCnt)
            nPrimeArr(nPrimeCnt) = nLoop
        End If
        nLoop = nLoop + 1
    Loop

    MsgBox nPrimeArr(nPrimeCnt), vbOKOnly, strMyTitle

End Sub
