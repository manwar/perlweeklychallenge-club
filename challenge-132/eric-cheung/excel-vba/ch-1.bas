Attribute VB_Name = "ModTask_01"
Option Explicit
Public Const strMyTitle As String = "Eric Cheung"

Sub Task_01()

    Dim strMsg As String
    Dim nDayAge As Long
    Dim strDateInput As String, strToday As String
    Dim Date_01 As Date, Date_02 As Date
    
    '' strDateInput = "2021-09-18" '' Example 1:
    '' strDateInput = "1975-10-10" '' Example 2:
    strDateInput = "1967-02-14" '' Example 3:
    
    strToday = "2021-09-22"
    
    nDayAge = DateDiff("d", strDateInput, strToday)
    
    Date_01 = DateAdd("d", -nDayAge, strDateInput)
    Date_02 = DateAdd("d", nDayAge, strToday)
    
    strMsg = Format(Date_01, "yyyy-mm-dd") & ", " & Format(Date_02, "yyyy-mm-dd")

    MsgBox strMsg, vbOKOnly, strMyTitle
    
End Sub
