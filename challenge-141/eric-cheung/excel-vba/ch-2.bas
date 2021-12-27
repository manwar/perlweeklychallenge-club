Attribute VB_Name = "ModTask_02"
Option Explicit
Public nNumCand() As Integer
Public nCount As Integer

Public Sub PerfCombination(ByRef nArrPool() As Integer, ByVal nNumElem As Integer)

    '' Credit: https://stackoverflow.com/questions/7198154/combination-algorithm-in-excel-vba

    Dim nTempIndx As Integer
    Dim nRowLoop As Integer, nColLoop As Integer
    Dim strTempNum As String

    nTempIndx = UBound(nArrPool) - LBound(nArrPool) + 1

    Dim nArrIndx() As Integer
    ReDim nArrIndx(1 To nNumElem)

    For nRowLoop = 1 To nNumElem
        nArrIndx(nRowLoop) = nRowLoop
    Next nRowLoop

    Do
        nCount = nCount + 1
        If nCount > 1 Then
            ReDim Preserve nNumCand(1 To nCount)
        End If
        
        strTempNum = ""
    
        For nColLoop = 1 To nNumElem
            strTempNum = strTempNum & CStr(nArrPool(nArrIndx(nColLoop)))
        Next nColLoop
        
        nNumCand(nCount) = Int(strTempNum)

        nRowLoop = nNumElem
        Do While nArrIndx(nRowLoop) = nTempIndx - nNumElem + nRowLoop
            nRowLoop = nRowLoop - 1
            If nRowLoop = 0 Then Exit Sub
        Loop

        nArrIndx(nRowLoop) = nArrIndx(nRowLoop) + 1

        For nColLoop = nRowLoop + 1 To nNumElem
            nArrIndx(nColLoop) = nArrIndx(nRowLoop) + nColLoop - nRowLoop
        Next nColLoop
    Loop While True

End Sub

Sub Task_02()

    '' Example 1
    '' Const nNumInput As Integer = 1234
    '' Const nDiv As Integer = 2
    
    '' Example 2
    Const nNumInput As Integer = 768
    Const nDiv As Integer = 4
    
    Dim nArr() As Integer
    Dim nLoop As Integer
    
    Dim strMsg As String
    
    ReDim nArr(1 To Len(CStr(nNumInput)))

    ReDim nNumCand(1 To 1)
    nCount = 0
    
    For nLoop = 1 To Len(CStr(nNumInput))
        nArr(nLoop) = Int(Mid(nNumInput, nLoop, 1))
    Next nLoop
    
    For nLoop = 1 To Len(CStr(nNumInput)) - 1
        PerfCombination nArr, nLoop
    Next nLoop
    
    For nLoop = LBound(nNumCand) To UBound(nNumCand)
        If nNumCand(nLoop) Mod nDiv = 0 Then
            If strMsg <> "" Then
                strMsg = strMsg & ", "
            End If
            strMsg = strMsg & nNumCand(nLoop)
        End If
    Next nLoop
    
    MsgBox strMsg, vbOKOnly, strMyTitle
    
End Sub
