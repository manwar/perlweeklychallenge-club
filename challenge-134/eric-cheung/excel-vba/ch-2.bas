Attribute VB_Name = "ModTask_02"
Option Explicit
Public Const strMyTitle As String = "Eric Cheung"

Sub Task_02()

    '' Example 01:
    '' Const nRowMax As Integer = 3
    '' Const nColMax As Integer = 3
    
    '' Example 02:
    Const nRowMax As Integer = 3
    Const nColMax As Integer = 5

    Dim strMsg As String, strUniqCountMsg As String
    Dim nMatrixArr(1 To nRowMax, 1 To nColMax) As Integer
    Dim nRowLoop As Integer, nColLoop As Integer, nUniqCount As Integer
    Dim objDict As Object
    
    Set objDict = CreateObject("Scripting.Dictionary")
    
    nUniqCount = 0
    
    strMsg = "x |"
    
    For nColLoop = 1 To nColMax
        strMsg = strMsg & "  " & nColLoop
    Next nColLoop
    
    strMsg = strMsg & vbNewLine & "--+-----------"
    
    For nRowLoop = 1 To nRowMax
        strMsg = strMsg & vbNewLine & nRowLoop & " |"
        For nColLoop = 1 To nColMax
            nMatrixArr(nRowLoop, nColLoop) = nRowLoop * nColLoop
            strMsg = strMsg & "  " & nRowLoop * nColLoop
            If Not objDict.exists(nRowLoop * nColLoop) Then
                objDict.Add nRowLoop * nColLoop, 1
                If strUniqCountMsg <> "" Then
                    strUniqCountMsg = strUniqCountMsg & ", "
                End If
                strUniqCountMsg = strUniqCountMsg & nRowLoop * nColLoop
                nUniqCount = nUniqCount + 1
            End If
        Next nColLoop
    Next nRowLoop
    
    strUniqCountMsg = "Distinct Terms: " & strUniqCountMsg & vbNewLine & "Count: " & nUniqCount
    
    strMsg = strMsg & vbNewLine & vbNewLine & strUniqCountMsg

    MsgBox strMsg, vbOKOnly, strMyTitle
    
    Set objDict = Nothing

End Sub
