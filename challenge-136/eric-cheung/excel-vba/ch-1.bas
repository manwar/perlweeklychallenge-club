Attribute VB_Name = "ModTask_01"
Option Explicit

Public Const strMyTitle As String = "Eric Cheung"

Function IsTwoFriendly(ByVal nInput_01 As Integer, nInput_02 As Integer) As Boolean

    Dim dPow As Double
    Dim wsFunc As Object

    Set wsFunc = Application.WorksheetFunction
    
    dPow = Log(wsFunc.Gcd(nInput_01, nInput_02)) / Log(2)
    
    If dPow > Int(dPow) Then
        IsTwoFriendly = False
    Else
        IsTwoFriendly = True
    End If
    
    Set wsFunc = Nothing

End Function

Sub Task_01()

    '' Example 1
    '' Const nNum_01 As Integer = 8
    '' Const nNum_02 As Integer = 24
    
    '' Example 2
    '' Const nNum_01 As Integer = 26
    '' Const nNum_02 As Integer = 39
    
    '' Example 3
    Const nNum_01 As Integer = 4
    Const nNum_02 As Integer = 10
    
    Dim strMsg As String
    
    If IsTwoFriendly(nNum_01, nNum_02) Then
        strMsg = "1"
    Else
        strMsg = "0"
    End If
    
    MsgBox strMsg, vbOKOnly, strMyTitle
    
End Sub
