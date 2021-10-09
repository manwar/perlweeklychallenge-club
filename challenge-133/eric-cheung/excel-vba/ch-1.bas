Attribute VB_Name = "ModTask_01"
Option Explicit
Public Const strMyTitle As String = "Eric Cheung"

Function FindIntDivTwo(nNum As Double) As Long

    FindIntDivTwo = Int(nNum / 2)

End Function

Function FindIntSqrRoot(nInput As Long) As Long
    
    Dim nTemp As Long
    
    nTemp = FindIntDivTwo(CDbl(nInput))
    
    If nTemp = 0 Then
        FindIntSqrRoot = nInput
        Exit Function
    End If
    
    FindIntSqrRoot = FindIntDivTwo(CDbl(nTemp + nInput / nTemp))

    Do While FindIntSqrRoot < nTemp
        nTemp = FindIntSqrRoot
        FindIntSqrRoot = FindIntDivTwo(CDbl(nTemp + nInput / nTemp))
    Loop
    
End Function

Sub Task_01()

    ''Remarks
    ''https://theweeklychallenge.org/blog/perl-weekly-challenge-133/
    ''https://en.wikipedia.org/wiki/Integer_square_root
    ''https://www.geeksforgeeks.org/left-shift-right-shift-operators-c-cpp/

    Dim strMsg As String
    Dim nIntSqr As Long

    '' nIntSqr = 10 '' Example: 1
    '' nIntSqr = 27 '' Example: 2
    '' nIntSqr = 85 '' Example: 3
    nIntSqr = 101 '' Example: 4

    strMsg = "Integer Square Root of " & nIntSqr & " is: " + CStr(FindIntSqrRoot(nIntSqr))

    MsgBox strMsg, vbOKOnly, strMyTitle

End Sub
