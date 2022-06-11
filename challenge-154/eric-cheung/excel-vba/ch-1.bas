Attribute VB_Name = "ModTask_01"
Option Explicit
Option Base 1

Public Const strMyTitle As String = "Eric Cheung"

Function IsInArray(stringToBeFound As String, arr As Variant) As Boolean
    IsInArray = Not IsError(Application.Match(stringToBeFound, arr, 0))
End Function

Sub Task_01()

    Const strInput As String = "PERL"
    
    Dim strPerArr() As Variant
    
    Dim nElemArr() As Integer
    Dim nElemArrCnt As Integer, nElemLoop As Integer
    Dim nRowLoop As Integer, nColLoop As Integer
    Dim bFlag As Boolean
    Dim strTemp As String, strMsg As String
    
    strPerArr = Array( _
        "PELR", "PREL", "PERL", "PRLE", _
        "PLER", "PLRE", "EPRL", "EPLR", _
        "ERPL", "ERLP", "ELPR", "ELRP", _
        "RPEL", "RPLE", "REPL", "RELP", _
        "RLPE", "RLEP", "LPER", "LPRE", _
        "LEPR", "LRPE", "LREP")
    
    nElemArrCnt = Len(strInput)
    
    ReDim nElemArr(1 To nElemArrCnt)
    
    nElemLoop = 1
    nElemArr(1) = 1
    
    Do
        Do While nElemArr(nElemLoop) <= nElemArrCnt
            Do While nElemLoop < nElemArrCnt
                nElemLoop = nElemLoop + 1
                nElemArr(nElemLoop) = 1
            Loop
            
            bFlag = True
            For nRowLoop = 1 To nElemArrCnt - 1
                For nColLoop = nRowLoop + 1 To nElemArrCnt
                    If nElemArr(nRowLoop) = nElemArr(nColLoop) Then
                        bFlag = False
                        Exit For
                    End If
                Next nColLoop
                If Not bFlag Then Exit For
            Next nRowLoop
            
            If bFlag Then
                For nRowLoop = 1 To nElemArrCnt
                    If nElemArr(nRowLoop) > nElemArrCnt Then
                        bFlag = False
                        Exit For
                    End If
                Next nRowLoop
            End If
            
            If bFlag Then
                strTemp = ""
                For nRowLoop = 1 To nElemArrCnt
                    strTemp = strTemp & Mid(strInput, nElemArr(nRowLoop), 1)
                Next nRowLoop
                If Not IsInArray(strTemp, strPerArr) Then
                    If strMsg <> "" Then
                        strMsg = strMsg & ", "
                    End If
                    strMsg = strMsg & strTemp
                End If
            End If
            
            nElemArr(nElemLoop) = nElemArr(nElemLoop) + 1
        Loop
        
        nElemLoop = nElemLoop - 1
        nElemArr(nElemLoop) = nElemArr(nElemLoop) + 1
        
    Loop Until nElemArr(1) > nElemArrCnt
    
    MsgBox strMsg, vbOKOnly, strMyTitle
    
End Sub
