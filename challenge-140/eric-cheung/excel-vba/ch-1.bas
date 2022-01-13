Attribute VB_Name = "ModTask_01"
Option Explicit

Public Const strMyTitle As String = "Eric Cheung"

Function BinaryNumAdd(ByVal strBinNum_01 As String, ByVal strBinNum_02 As String) As String
    
    Dim wsFunc As Object
    
    Set wsFunc = Application.WorksheetFunction
    
    BinaryNumAdd = wsFunc.Dec2Bin(wsFunc.Bin2Dec(strBinNum_01) + wsFunc.Bin2Dec(strBinNum_02))
    
    Set wsFunc = Nothing
    
End Function

Sub Task_01()

    Dim strMsg As String
    
    '' strMsg = BinaryNumAdd("11", "1") '' Example 1
    '' strMsg = BinaryNumAdd("101", "1") '' Example 2
    strMsg = BinaryNumAdd("100", "11") '' Example 3
    
    MsgBox strMsg, vbOKOnly, strMyTitle
    
End Sub
