Attribute VB_Name = "ModTask_01"
Option Explicit

Public Const strMyTitle As String = "Eric Cheung"

Sub Task_01()

    '' Const nInputYear As Integer = 2021 '' Example 1
    Const nInputYear As Integer = 2020 '' Example 2

    Dim strMsg As String
    
    strMsg = CStr(Application.WorksheetFunction.NetworkDays(DateSerial(nInputYear, 1, 1), DateSerial(nInputYear, 12, 31)))
    
    MsgBox strMsg, vbOKOnly, strMyTitle
    
End Sub
