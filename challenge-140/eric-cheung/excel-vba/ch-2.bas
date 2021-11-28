Attribute VB_Name = "ModTask_02"
Option Explicit

Sub Task_02()

    '' Example 1
''    Const nNumRow As Integer = 2
''    Const nNumCol As Integer = 3
''    Const nElemNum As Integer = 4
    
    '' Example 2
    Const nNumRow As Integer = 3
    Const nNumCol As Integer = 3
    Const nElemNum As Integer = 6

    Dim strMsg As String
    Dim nRowLoop As Integer, nColLoop As Integer, nLoop As Integer
    Dim nArr(1 To nNumRow * nNumCol) As Integer
    
    '' Initialize
    nLoop = 1
    For nRowLoop = 1 To nNumRow
        For nColLoop = 1 To nNumCol
            nArr(nLoop) = nRowLoop * nColLoop
            nLoop = nLoop + 1
        Next nColLoop
    Next nRowLoop
    
    '' Sort
    For nRowLoop = 1 To nNumRow * nNumCol - 1
        For nColLoop = nRowLoop + 1 To nNumRow * nNumCol
            If nArr(nRowLoop) > nArr(nColLoop) Then
                nLoop = nArr(nRowLoop)
                nArr(nRowLoop) = nArr(nColLoop)
                nArr(nColLoop) = nLoop
            End If
        Next nColLoop
    Next nRowLoop
    
    '' Display
    strMsg = "Now the " & nElemNum
    
    If nElemNum = 1 Then
        strMsg = strMsg & "st"
    ElseIf nElemNum = 2 Then
        strMsg = strMsg & "nd"
    ElseIf nElemNum = 3 Then
        strMsg = strMsg & "rd"
    Else
        strMsg = strMsg & "th"
    End If

    strMsg = strMsg & " element in the table is " & nArr(nElemNum)

    MsgBox strMsg, vbOKOnly, strMyTitle
    
End Sub
