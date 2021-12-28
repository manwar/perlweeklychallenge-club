Attribute VB_Name = "ModTask_01"
Option Explicit

Public Const strMyTitle As String = "Eric Cheung"

Sub Task_01()
'' Dot Product

    Dim strMsg As String
    
    Dim dArr_A() As Variant, dArr_B() As Variant
    Dim nLoop As Integer
    Dim dSum As Double
    
    dArr_A = Array(1, 2, 3)
    dArr_B = Array(4, 5, 6)
    
    If UBound(dArr_A) - LBound(dArr_A) <> UBound(dArr_B) - LBound(dArr_B) Then
        strMsg = "Inconsistent Array Size"
        Exit Sub
    End If
    
    For nLoop = LBound(dArr_A) To UBound(dArr_A)
        dSum = dSum + dArr_A(nLoop) * dArr_B(nLoop)
    Next nLoop

    MsgBox dSum, vbOKOnly, strMyTitle
    
End Sub


