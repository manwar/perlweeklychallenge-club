Attribute VB_Name = "ModTask_01"
Option Explicit
Option Base 1
Public Const strMyTitle As String = "Eric Cheung"

Function GetCountNum(nNum) As Long

    Dim nLoop As Long, nCntItem As Long, nTenNum As Long, nResult As Long, nTemp As Long, nTenPower As Long
    Dim nNumArr As Variant
    
    If nNum <= 1 Then
        GetCountNum = 0
        Exit Function
    End If
    
    nCntItem = 9
    nNumArr = Array(0, 2, 3, 4, 5, 6, 7, 8, 9)
    
    nTenNum = 0
    nResult = 0
    nTenPower = 1
    
    Do While True
        For nLoop = 1 To nCntItem
            nTemp = nTenNum * 10 + nNumArr(nLoop)
            If nTemp = nNum Then
                GetCountNum = nResult 'Exclude 0
                Exit Function
            ElseIf nTemp > nNum Then
                GetCountNum = nResult - 1 'Exclude 0
                Exit Function
            End If
            nResult = nResult + 1
        Next nLoop
        
        If nTenNum Mod 10 = 0 Then ''E.g. nTenNum: 0, 20, 30, 40, ...
            nTenNum = nTenNum + 2
        ElseIf nTenNum = nTenPower * 10 - 1 Then ''E.g. nTenNum: 9, 99, 999, ...
            nTenPower = nTenPower * 10
            nTenNum = nTenNum + nTenPower + 1
        Else
            nTenNum = nTenNum + 1
        End If
    Loop
    
End Function

Sub Task_01()

    Dim varInputNum
    Dim strMsg As String
    
    Do
        varInputNum = InputBox("Please enter a positive number", strMyTitle, 15)
        If varInputNum = "" Then Exit Sub
    Loop Until varInputNum > 0

    strMsg = "There are " & GetCountNum(varInputNum) & " numbers between 1 and " & varInputNum & " that don't contain digit 1"

    MsgBox strMsg, vbOKOnly, strMyTitle
    
End Sub
