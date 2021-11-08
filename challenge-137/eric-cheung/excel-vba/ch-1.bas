Attribute VB_Name = "ModTask_01"
Option Explicit

Public Const strMyTitle As String = "Eric Cheung"

Function FindWeekNumGivenDate(nInputDate As Long) As Integer

    '' Credit:
    '' http://kbase.icbconsulting.com/vba/determine-the-week-number-using-a-date

    Dim nNum_01 As Integer, nNum_02 As Integer, nNum_03 As Long, nNum_04 As Integer

    If nInputDate < 1 Then
        FindWeekNumGivenDate = 0
        Exit Function
    End If

    nNum_01 = Weekday(nInputDate, vbSunday)
    nNum_02 = Year(nInputDate + (8 - nNum_01) Mod 7 - 3)
    nNum_03 = DateSerial(nNum_02, 1, 1)
    nNum_04 = (Weekday(nNum_03, vbSunday) + 1) Mod 7
    FindWeekNumGivenDate = Int((nInputDate - nNum_03 - 3 + nNum_04) / 7) + 1

End Function

Function FindNumWeekGivenYear(nInputYear As Integer) As Integer

    FindNumWeekGivenYear = FindWeekNumGivenDate(DateSerial(nInputYear, 12, 31))

End Function

Sub Task_01()

    Const nStartYear As Integer = 1900
    Const nStartEnd As Integer = 2100
    
    Dim strMsg As String
    Dim nLoop As Integer
    
    For nLoop = nStartYear To nStartEnd
        If FindNumWeekGivenYear(nLoop) = 53 Then
            If strMsg <> "" Then
                strMsg = strMsg & ", "
            End If
            strMsg = strMsg & nLoop
        End If
    Next nLoop
    
    MsgBox strMsg, vbOKOnly, strMyTitle
    
End Sub
