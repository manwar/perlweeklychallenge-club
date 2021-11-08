Attribute VB_Name = "ModTask_02"
Option Explicit

'' Credit:
'' https://en.wikipedia.org/wiki/SEDOL
'' http://rosettacode.org/wiki/SEDOLs
'' http://excelevolution.com/validate-sedol-using-vba/

Public g_objREGEX As Object
 
Public Function CharToDigit(ByVal strSecurity As String) As Variant
    Dim objMatch As Object
    Dim objMatches As Object
    Dim strStagingString As String

    If g_objREGEX Is Nothing Then
        Set g_objREGEX = CreateObject("vbscript.regexp")
    End If

    With g_objREGEX
        .Global = True
        .IgnoreCase = False
        .Pattern = "([A-Z])"
    End With

    strStagingString = Left$(StrConv(strSecurity, vbUnicode), Len(strSecurity) * 2 - 1)

    Set objMatches = g_objREGEX.Execute(strStagingString)

    For Each objMatch In objMatches
        strStagingString = Replace$(strStagingString, objMatch.Value, Asc(objMatch.Value) - (Asc("A") - 10))
    Next objMatch

    CharToDigit = Split(strStagingString, Chr$(0))
End Function
 
Public Function IsSEDOLPattern(ByVal strSEDOL As String) As Boolean
    If g_objREGEX Is Nothing Then
        Set g_objREGEX = CreateObject("vbscript.regexp")
    End If
 
    With g_objREGEX
        .IgnoreCase = False
        .Pattern = "^[B-DF-HJ-NP-TV-Z0-9]{6}[0-9]{1}$"
    End With
 
    IsSEDOLPattern = g_objREGEX.Test(strSEDOL)
End Function

Public Function IsValidSEDOL(ByVal strSEDOL As String, Optional ByVal blnNew As Boolean = False) As Boolean
    Dim lngCheckNum As Long
    Dim varNums As Variant
    Dim lngResult As Long
    
    Const nBaseTen As Integer = 10

    strSEDOL = UCase$(Format$(strSEDOL, "0000000"))

    If Not IsSEDOLPattern(strSEDOL) Then
        IsValidSEDOL = False
        Exit Function
    End If

    If blnNew Then
        If IsNumeric(Left(strSEDOL, 1)) Then
            IsValidSEDOL = False
            Exit Function
        End If
    End If

    lngCheckNum = CLng(Right$(strSEDOL, 1))

    varNums = Join$(CharToDigit(Left$(strSEDOL, 6)), ",")

    lngResult = (nBaseTen - (Evaluate("sumproduct({" & varNums & "},{1,3,1,7,3,9})") Mod nBaseTen)) Mod nBaseTen

    IsValidSEDOL = CBool(lngCheckNum = lngResult)
End Function

Sub Task_02()

    '' Const strSEDOLToCheck As String = "2936921" '' Example: 1
    '' Const strSEDOLToCheck As String = "1234567" '' Example: 2
    Const strSEDOLToCheck As String = "B0YBKL9" '' Example: 3

    Dim strMsg As String
    
    If IsValidSEDOL(strSEDOLToCheck) Then
        strMsg = "1"
    Else
        strMsg = "0"
    End If

    MsgBox strMsg, vbOKOnly, strMyTitle

    If Not g_objREGEX Is Nothing Then
        Set g_objREGEX = Nothing
    End If

End Sub
