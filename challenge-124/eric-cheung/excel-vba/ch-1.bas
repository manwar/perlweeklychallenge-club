Attribute VB_Name = "ModTask_01"
Option Explicit
Public Const strMyTitle As String = "Eric Cheung"

Sub Task_01()

    Dim strMsg As String

    strMsg = "    ^^^^^"
    strMsg = strMsg & vbNewLine & "   ^          ^"
    strMsg = strMsg & vbNewLine & "  ^            ^"
    strMsg = strMsg & vbNewLine & " ^              ^"
    strMsg = strMsg & vbNewLine & "^                ^"
    strMsg = strMsg & vbNewLine & "^                ^"
    strMsg = strMsg & vbNewLine & "^                ^"
    strMsg = strMsg & vbNewLine & "^                ^"
    strMsg = strMsg & vbNewLine & "^               ^"
    strMsg = strMsg & vbNewLine & " ^             ^"
    strMsg = strMsg & vbNewLine & "    ^^^^^"
    strMsg = strMsg & vbNewLine & "          ^"
    strMsg = strMsg & vbNewLine & "          ^"
    strMsg = strMsg & vbNewLine & "          ^"
    strMsg = strMsg & vbNewLine & "    ^^^^^"
    strMsg = strMsg & vbNewLine & "          ^"
    strMsg = strMsg & vbNewLine & "          ^"
      
    MsgBox strMsg, vbOKOnly, strMyTitle
    
End Sub
