Attribute VB_Name = "ModTask_01"
Option Explicit

Public Const strMyTitle As String = "Eric Cheung"

Function ConvUnitDigitToWord(ByVal nUnitDigit As Integer) As String

    Select Case nUnitDigit
        Case 1
            ConvUnitDigitToWord = "One"
        Case 2
            ConvUnitDigitToWord = "Two"
        Case 3
            ConvUnitDigitToWord = "Three"
        Case 4
            ConvUnitDigitToWord = "Four"
        Case 5
            ConvUnitDigitToWord = "Five"
        Case 6
            ConvUnitDigitToWord = "Six"
        Case 7
            ConvUnitDigitToWord = "Seven"
        Case 8
            ConvUnitDigitToWord = "Eight"
        Case 9
            ConvUnitDigitToWord = "Nine"
    End Select

End Function

Function ConvElevenToNineteenWord(ByVal nInput As Integer) As String
    
    Select Case nInput
        Case 11
            ConvElevenToNineteenWord = "Eleven"
        Case 12
            ConvElevenToNineteenWord = "Twelve"
        Case 13
            ConvElevenToNineteenWord = "Thirteen"
        Case 14
            ConvElevenToNineteenWord = "Forteen"
        Case 15
            ConvElevenToNineteenWord = "Fifteen"
        Case 16
            ConvElevenToNineteenWord = "Sixteen"
        Case 17
            ConvElevenToNineteenWord = "Seventeen"
        Case 18
            ConvElevenToNineteenWord = "Eighteen"
        Case 19
            ConvElevenToNineteenWord = "Nineteen"
    End Select
    
End Function

Function ConvTenDigitToWord(ByVal nTenDigit As Integer) As String

    Select Case nTenDigit
        Case 2
            ConvTenDigitToWord = "Twenty"
        Case 3
            ConvTenDigitToWord = "Thirty"
        Case 4
            ConvTenDigitToWord = "Forty"
        Case 5
            ConvTenDigitToWord = "Fifty"
        Case 6
            ConvTenDigitToWord = "Sixty"
        Case 7
            ConvTenDigitToWord = "Seventy"
        Case 8
            ConvTenDigitToWord = "Eighty"
        Case 9
            ConvTenDigitToWord = "Ninety"
    End Select

End Function

Function ConvNumToWord(ByVal nInput As Integer) As String

    If nInput > 100 Then
        ConvNumToWord = ""
        Exit Function
    End If
    
    If nInput = 0 Then
        ConvNumToWord = "Zero"
        Exit Function
    End If
    
    If nInput < 0 Then
        ConvNumToWord = ""
        Exit Function
    End If
    
    If nInput = 100 Then
        ConvNumToWord = "One Hundred"
    ElseIf nInput < 10 Then
        ConvNumToWord = ConvUnitDigitToWord(nInput)
    ElseIf nInput = 10 Then
        ConvNumToWord = "Ten"
    ElseIf nInput < 20 Then
        ConvNumToWord = ConvElevenToNineteenWord(nInput)
    ElseIf nInput Mod 10 = 0 Then
        ConvNumToWord = ConvTenDigitToWord(nInput / 10)
    Else
        ConvNumToWord = ConvTenDigitToWord(Int(nInput / 10)) & " " & ConvUnitDigitToWord(nInput Mod 10)
    End If

End Function

Sub Task_01()

    '' Remarks
    '' https://en.wikipedia.org/wiki/Ban_number#:~:text=The%20first%20few%20eban%20numbers,in%20the%20sequence%20are%20even.

    Dim strMsg As String
    Dim nLoop As Integer
    
    For nLoop = 1 To 100
        If InStr(1, LCase(ConvNumToWord(nLoop)), "e") = 0 Then
            If strMsg <> "" Then
                strMsg = strMsg & ", "
            End If
            strMsg = strMsg & nLoop
        End If
    Next nLoop

    MsgBox strMsg, vbOKOnly, strMyTitle

End Sub
