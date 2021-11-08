Attribute VB_Name = "ModTask_02"
Option Explicit
'https://www.varsitytutors.com/basic_geometry-help/how-to-find-the-angle-of-clock-hands
'https://www.omnicalculator.com/math/clock-angle#method-2-use-a-clock-angle-formula

Function ClockAngle(strTime) As Double

    Const nSectorToDegree As Integer = 30
    Const nDayToHour As Integer = 12
    Const nDiv As Integer = 5

    Dim nHour As Integer, dMinute As Double, dFactor As Double
    
    nHour = Val(Left(strTime, 2)) Mod nDayToHour
    dMinute = Val(Right(strTime, 2)) / nDiv
    
    ClockAngle = Abs(nHour - dMinute) * nSectorToDegree
    
    If dMinute > 0 Then
        dFactor = dMinute * nSectorToDegree / nDayToHour
        If nHour >= dMinute Then
            ClockAngle = ClockAngle + dFactor
        Else
            ClockAngle = ClockAngle - dFactor
        End If
    End If
    
    ClockAngle = Abs(Round(ClockAngle, 2))
    
    If ClockAngle > 180 Then
        ClockAngle = 360 - ClockAngle
    End If

End Function

Sub Task_02()

    Dim varInputNum
    
    Do
        varInputNum = InputBox("Please enter the time", strMyTitle, "04:00")
        If varInputNum = "" Then Exit Sub
    Loop Until varInputNum <> ""
    
    MsgBox "The smallest angle spanned by the time " & varInputNum & " is: " & ClockAngle(varInputNum) & " degrees"
    
End Sub
