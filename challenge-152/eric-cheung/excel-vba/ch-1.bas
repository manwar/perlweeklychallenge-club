Attribute VB_Name = "ModTask_01"
Option Explicit

Public Const strMyTitle As String = "Eric Cheung"

Sub Task_01()

    Dim nTriArr() As Variant
    Dim nPathSum As Integer, nSubMin As Integer
    Dim nLoop As Integer, nCount As Integer, nStep As Integer
    
    '' nTriArr = Array(1, 5, 3, 2, 3, 4, 7, 1, 0, 2, 6, 4, 5, 2, 8) '' Example 1
    nTriArr = Array(5, 2, 3, 4, 1, 5, 0, 1, 2, 3, 7, 2, 4, 1, 9) '' Example 2
    
    nCount = 0
    nStep = 1
    nSubMin = 10000
    
    For nLoop = LBound(nTriArr) To UBound(nTriArr)
        nCount = nCount + 1
        If nTriArr(nLoop) < nSubMin Then
            nSubMin = nTriArr(nLoop)
        End If

        If nStep = nCount Then
            nPathSum = nPathSum + nSubMin

            nCount = 0
            nStep = nStep + 1
            nSubMin = 10000
        End If
    Next nLoop

    MsgBox nPathSum, vbOKOnly, strMyTitle

End Sub
