Attribute VB_Name = "ModTask_01"
Option Explicit

Public Const strMyTitle As String = "Eric Cheung"

Sub Task_01()

    '' Example 1
    '' Const nNumInput As Integer = 24
    '' Const nLastDigit As Integer = 2
    
    '' Example 2
    Const nNumInput As Integer = 30
    Const nLastDigit As Integer = 5

    Dim nLoop As Integer
    Dim nCount As Integer
    
    nCount = 0

    If nLastDigit = 1 Then
        nCount = nCount + 1
    End If
    
    If nNumInput Mod 10 = nLastDigit Then
        nCount = nCount + 1
    End If
    
    For nLoop = 2 To nNumInput - 2
        If _
            nNumInput Mod nLoop = 0 _
            And nNumInput Mod 10 = nLastDigit _
        Then
            nCount = nCount + 1
        End If
    Next nLoop

    MsgBox nCount, vbOKOnly, strMyTitle
    
End Sub


