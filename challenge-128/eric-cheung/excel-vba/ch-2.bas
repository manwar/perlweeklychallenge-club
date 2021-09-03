Attribute VB_Name = "ModTask_02"
Option Explicit
Option Base 1

Sub Task_02()

    ''Const nTrainNum As Integer = 2
    Const nTrainNum As Integer = 6

    Dim strArrivalArr(1 To nTrainNum) As String, strDepartArr(1 To nTrainNum) As String
    Dim strPlatFormDepart() As String, nPlatFormNum As Integer
    Dim nLoop As Integer, nSubLoop As Integer, nTemp As Integer
    Dim strMsg As String
    
    ReDim strPlatFormDepart(1 To 1)
    
    'Initialize
''    strArrivalArr(1) = "11:20": strArrivalArr(2) = "14:30"
''    strDepartArr(1) = "11:50": strDepartArr(2) = "15:00"
    
    strArrivalArr(1) = "10:20": strArrivalArr(2) = "11:00": strArrivalArr(3) = "11:10": strArrivalArr(4) = "12:20": strArrivalArr(5) = "16:20": strArrivalArr(6) = "19:00"
    strDepartArr(1) = "10:30": strDepartArr(2) = "13:20": strDepartArr(3) = "12:40": strDepartArr(4) = "12:50": strDepartArr(5) = "20:20": strDepartArr(6) = "21:20"
    
    nPlatFormNum = 1
    
    If nTrainNum > 1 Then
        For nLoop = 1 To nTrainNum
            If nLoop > 1 Then
                nTemp = nPlatFormNum
                For nSubLoop = 1 To nPlatFormNum
                    If strArrivalArr(nLoop) < strPlatFormDepart(nSubLoop) Then
                        nTemp = nTemp - 1
                    Else
                        strPlatFormDepart(nSubLoop) = strDepartArr(nLoop)
                        Exit For
                    End If
                Next nSubLoop
                If nTemp = 0 Then
                    nPlatFormNum = nPlatFormNum + 1
                    ReDim Preserve strPlatFormDepart(1 To nPlatFormNum)
                    strPlatFormDepart(nPlatFormNum) = strDepartArr(nLoop)
                End If
            Else
                strPlatFormDepart(nLoop) = strDepartArr(nLoop)
            End If
        Next nLoop
    End If
    
    strMsg = "Minimum " & nPlatFormNum & " platform(s) is/are needed"

    MsgBox strMsg, vbOKOnly, strMyTitle
    
End Sub

