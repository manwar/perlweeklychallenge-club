Attribute VB_Name = "ModTask_01"
Option Explicit
Public Const strMyTitle As String = "Eric Cheung"

Function IsUgly(nNum As Integer) As Boolean

    IsUgly = False

    If _
        nNum = 1 _
        Or nNum = 2 _
        Or nNum = 3 _
        Or nNum = 5 _
        Or nNum Mod 2 = 0 _
        Or nNum Mod 3 = 0 _
        Or nNum Mod 5 = 0 _
    Then
        IsUgly = True
        Exit Function
    End If
    
End Function

Sub Task_01()

    Dim varInputNum
    Dim nCount As Integer, nUglyCount As Integer
    Dim strMsg As String
    
    Do
        varInputNum = InputBox("Please enter a positive integer", strMyTitle, 1)
        If varInputNum = "" Then Exit Sub
    Loop Until varInputNum > 0
    
    nCount = 0
    nUglyCount = 0
    
    Do
        nCount = nCount + 1
        If IsUgly(nCount) Then
            nUglyCount = nUglyCount + 1
        End If
    Loop Until (nUglyCount = varInputNum)
    
    strMsg = "The " & varInputNum & "th ugly number is: " & nCount
    MsgBox strMsg, vbOKOnly, strMyTitle
    
End Sub
