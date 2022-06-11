Attribute VB_Name = "ModTask_01"
Option Explicit

Public Const strMyTitle As String = "Eric Cheung"

Function GetSumOfDigit(ByVal nNum As Integer) As Integer

    Dim nSubLoop As Integer
    
    For nSubLoop = 1 To Len(CStr(nNum))
        GetSumOfDigit = GetSumOfDigit + CInt(Mid(CStr(nNum), nSubLoop, 1))
    Next nSubLoop

End Function

Function IsInArray(nValToFind As Variant, nArr As Variant) As Boolean

    '' Credit:
    '' https://wellsr.com/vba/2016/excel/check-if-value-is-in-array-vba/

    Dim nElem As Variant
    
    IsInArray = False
    
    For Each nElem In nArr
        If nElem = nValToFind Then
            IsInArray = True
            Exit Function
        End If
    Next nElem
    
End Function

Sub Task_01()

    Const MyNumMax As Integer = 20

    Dim nLoop As Integer, nCount As Integer
    Dim strMsg As String
    Dim nFibArr(1 To MyNumMax) As Integer
    
    nFibArr(1) = 0: nFibArr(2) = 1
    
    For nLoop = 3 To MyNumMax
        nFibArr(nLoop) = nFibArr(nLoop - 2) + nFibArr(nLoop - 1)
    Next nLoop
    
    nLoop = 0
    nCount = 0
    
    Do While (nCount < MyNumMax)
        If IsInArray(GetSumOfDigit(nLoop), nFibArr) Then
            nCount = nCount + 1
            If strMsg <> "" Then
                strMsg = strMsg & ", "
            End If
            strMsg = strMsg & CStr(nLoop)
        End If
        nLoop = nLoop + 1
    Loop

    MsgBox strMsg, vbOKOnly, strMyTitle

End Sub
