Attribute VB_Name = "ModTask_01"
Option Explicit
Option Base 1
Public Const strMyTitle As String = "Eric Cheung"

Sub Task_01()

    Dim nArr_01() As Variant, nArr_02() As Variant, nArrCom() As Variant
    Dim nArrSize_01 As Integer, nArrSize_02 As Integer
    Dim nLoop As Integer, nFindIndx As Integer, nCnt As Integer
    Dim strMsg As String
    Dim objApp As Object
    
    Set objApp = Application.WorksheetFunction
    
    nArr_01 = Array(1, 2, 5, 3, 4)
    nArr_02 = Array(4, 6, 7, 8, 9)
    
    nArrSize_01 = UBound(nArr_01) - LBound(nArr_01) + 1
    nArrSize_02 = UBound(nArr_02) - LBound(nArr_02) + 1
    
    nCnt = 0
    
    For nLoop = 1 To objApp.Min(nArrSize_01, nArrSize_02)
        nFindIndx = 0
        On Error Resume Next
        nFindIndx = objApp.Match(nArr_01(nLoop), nArr_02, 0)
        On Error GoTo 0
        If nFindIndx > 0 Then
            nCnt = nCnt + 1
            If nCnt > 1 Then
                ReDim Preserve nArrCom(1 To nCnt)
            Else
                ReDim nArrCom(1 To nCnt)
            End If
            nArrCom(nCnt) = nArr_01(nLoop)
        End If
    Next nLoop
    
    If nCnt > 0 Then
        strMsg = "0 as the given two sets have common member "
        For nLoop = 1 To nCnt
            If nLoop > 1 Then
                strMsg = strMsg & ", "
            End If
            strMsg = strMsg & nArrCom(nLoop)
        Next nLoop
    Else
        strMsg = "1 as the given two sets do not have common member"
    End If

    MsgBox strMsg, vbOKOnly, strMyTitle
    
    Set objApp = Nothing
    
End Sub
