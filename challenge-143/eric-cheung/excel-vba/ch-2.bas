Attribute VB_Name = "ModTask_02"
Option Explicit

Public Const strMyTitle As String = "Eric Cheung"

Sub Task_02() '' Stealthy Number

    '' Const nInpuNum As Integer = 36 '' Example 1
    '' Const nInpuNum As Integer = 12 '' Example 2
    Const nInpuNum As Integer = 6 '' Example 3
    
    Dim nLoop As Integer, nSubLoop As Integer, nCnt As Integer
    Dim bIsPrime As Boolean
    
    Dim nFactorArr_01() As Integer, nFactorArr_02()
    
    ReDim nFactorArr_01(1 To 1)
    ReDim nFactorArr_02(1 To 1)
    
    nCnt = 1
    nFactorArr_01(1) = 1: nFactorArr_02(1) = nInpuNum
    
    bIsPrime = True
    For nLoop = 2 To Sqr(nInpuNum)
        If nInpuNum Mod nLoop = 0 Then
            bIsPrime = False
            
            nCnt = nCnt + 1
            ReDim Preserve nFactorArr_01(1 To nCnt)
            ReDim Preserve nFactorArr_02(1 To nCnt)
            
            nFactorArr_01(nCnt) = nLoop
            nFactorArr_02(nCnt) = nInpuNum / nLoop
        End If
    Next nLoop
    
    If bIsPrime Then
        MsgBox 0, vbOKOnly, strMyTitle
        Exit Sub
    End If

    For nLoop = LBound(nFactorArr_01) To UBound(nFactorArr_01) - 1
        For nSubLoop = nLoop + 1 To UBound(nFactorArr_01)
            If Abs(nFactorArr_01(nLoop) + nFactorArr_02(nLoop) - nFactorArr_01(nSubLoop) - nFactorArr_02(nSubLoop)) = 1 Then
                MsgBox 1, vbOKOnly, strMyTitle
                Exit Sub
            End If
        Next nSubLoop
    Next nLoop
    
    MsgBox 0, vbOKOnly, strMyTitle

End Sub


