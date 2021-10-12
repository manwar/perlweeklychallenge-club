Attribute VB_Name = "ModTask_01"
Option Explicit
Option Base 1
Public Const nBase As Integer = 10

Sub myShiftArrayIndx(nArr, nIndx As Integer)
    
    Dim nIndxSubLoop As Integer
    
    For nIndxSubLoop = nIndx + 1 To nBase
        nArr(nIndxSubLoop - 1) = nArr(nIndxSubLoop)
    Next nIndxSubLoop
    
End Sub

Function GetPanDigitalMsg() As String
    '' Remarks
    '' https://www.geeksforgeeks.org/pandigital-number-given-base/

    Dim strNum As String
    Dim nLoop As Integer, nCnt As Integer
    Dim nIndxLoop(1 To nBase) As Integer, nArrIndx(1 To nBase) As Integer, nIntChosen(1 To nBase) As Integer
    Dim nBackupArr(1 To nBase, 1 To nBase) As Integer
    Dim bFlagArr(1 To nBase) As Boolean

    nCnt = 0
    nIndxLoop(1) = 2
    
    Do While nIndxLoop(1) <= nBase
        For nLoop = 1 To nBase
            nArrIndx(nLoop) = nLoop - 1 ''0 .. 9
        Next nLoop
        
        nIntChosen(1) = nArrIndx(nIndxLoop(1))
        myShiftArrayIndx nArrIndx, nIndxLoop(1)

        nIndxLoop(2) = 1
        bFlagArr(2) = True
        
        Do While nIndxLoop(2) <= 9
            If bFlagArr(2) Then
                nBackupArr(2, 1) = nArrIndx(nIndxLoop(2))
                nBackupArr(2, 2) = nArrIndx(2)
                nBackupArr(2, 3) = nArrIndx(3)
                nBackupArr(2, 4) = nArrIndx(4)
                nBackupArr(2, 5) = nArrIndx(5)
                nBackupArr(2, 6) = nArrIndx(6)
                nBackupArr(2, 7) = nArrIndx(7)
                nBackupArr(2, 8) = nArrIndx(8)
                nBackupArr(2, 9) = nArrIndx(9)
                bFlagArr(2) = False
            Else
                nArrIndx(1) = nBackupArr(2, 1)
                nArrIndx(2) = nBackupArr(2, 2)
                nArrIndx(3) = nBackupArr(2, 3)
                nArrIndx(4) = nBackupArr(2, 4)
                nArrIndx(5) = nBackupArr(2, 5)
                nArrIndx(6) = nBackupArr(2, 6)
                nArrIndx(7) = nBackupArr(2, 7)
                nArrIndx(8) = nBackupArr(2, 8)
                nArrIndx(9) = nBackupArr(2, 9)
            End If
        
            nIntChosen(2) = nArrIndx(nIndxLoop(2))
            myShiftArrayIndx nArrIndx, nIndxLoop(2)
            
            nIndxLoop(3) = 1
            bFlagArr(3) = True
            
            Do While nIndxLoop(3) <= 8
                If bFlagArr(3) Then
                    nBackupArr(3, 1) = nArrIndx(nIndxLoop(3))
                    nBackupArr(3, 2) = nArrIndx(2)
                    nBackupArr(3, 3) = nArrIndx(3)
                    nBackupArr(3, 4) = nArrIndx(4)
                    nBackupArr(3, 5) = nArrIndx(5)
                    nBackupArr(3, 6) = nArrIndx(6)
                    nBackupArr(3, 7) = nArrIndx(7)
                    nBackupArr(3, 8) = nArrIndx(8)
                    bFlagArr(3) = False
                Else
                    nArrIndx(1) = nBackupArr(3, 1)
                    nArrIndx(2) = nBackupArr(3, 2)
                    nArrIndx(3) = nBackupArr(3, 3)
                    nArrIndx(4) = nBackupArr(3, 4)
                    nArrIndx(5) = nBackupArr(3, 5)
                    nArrIndx(6) = nBackupArr(3, 6)
                    nArrIndx(7) = nBackupArr(3, 7)
                    nArrIndx(8) = nBackupArr(3, 8)
                End If
            
                nIntChosen(3) = nArrIndx(nIndxLoop(3))
                myShiftArrayIndx nArrIndx, nIndxLoop(3)
                
                nIndxLoop(4) = 1
                bFlagArr(4) = True
                
                Do While nIndxLoop(4) <= 7
                    If bFlagArr(4) Then
                        nBackupArr(4, 1) = nArrIndx(nIndxLoop(4))
                        nBackupArr(4, 2) = nArrIndx(2)
                        nBackupArr(4, 3) = nArrIndx(3)
                        nBackupArr(4, 4) = nArrIndx(4)
                        nBackupArr(4, 5) = nArrIndx(5)
                        nBackupArr(4, 6) = nArrIndx(6)
                        nBackupArr(4, 7) = nArrIndx(7)
                        bFlagArr(4) = False
                    Else
                        nArrIndx(1) = nBackupArr(4, 1)
                        nArrIndx(2) = nBackupArr(4, 2)
                        nArrIndx(3) = nBackupArr(4, 3)
                        nArrIndx(4) = nBackupArr(4, 4)
                        nArrIndx(5) = nBackupArr(4, 5)
                        nArrIndx(6) = nBackupArr(4, 6)
                        nArrIndx(7) = nBackupArr(4, 7)
                    End If
                
                    nIntChosen(4) = nArrIndx(nIndxLoop(4))
                    myShiftArrayIndx nArrIndx, nIndxLoop(4)
                    
                    nIndxLoop(5) = 1
                    bFlagArr(5) = True
                    
                    Do While nIndxLoop(5) <= 6
                        If bFlagArr(5) Then
                            nBackupArr(5, 1) = nArrIndx(nIndxLoop(5))
                            nBackupArr(5, 2) = nArrIndx(2)
                            nBackupArr(5, 3) = nArrIndx(3)
                            nBackupArr(5, 4) = nArrIndx(4)
                            nBackupArr(5, 5) = nArrIndx(5)
                            nBackupArr(5, 6) = nArrIndx(6)
                            bFlagArr(5) = False
                        Else
                            nArrIndx(1) = nBackupArr(5, 1)
                            nArrIndx(2) = nBackupArr(5, 2)
                            nArrIndx(3) = nBackupArr(5, 3)
                            nArrIndx(4) = nBackupArr(5, 4)
                            nArrIndx(5) = nBackupArr(5, 5)
                            nArrIndx(6) = nBackupArr(5, 6)
                        End If
                    
                        nIntChosen(5) = nArrIndx(nIndxLoop(5))
                        myShiftArrayIndx nArrIndx, nIndxLoop(5)
                        
                        nIndxLoop(6) = 1
                        bFlagArr(6) = True
                        
                        Do While nIndxLoop(6) <= 5
                            If bFlagArr(6) Then
                                nBackupArr(6, 1) = nArrIndx(nIndxLoop(6))
                                nBackupArr(6, 2) = nArrIndx(2)
                                nBackupArr(6, 3) = nArrIndx(3)
                                nBackupArr(6, 4) = nArrIndx(4)
                                nBackupArr(6, 5) = nArrIndx(5)
                                bFlagArr(6) = False
                            Else
                                nArrIndx(1) = nBackupArr(6, 1)
                                nArrIndx(2) = nBackupArr(6, 2)
                                nArrIndx(3) = nBackupArr(6, 3)
                                nArrIndx(4) = nBackupArr(6, 4)
                                nArrIndx(5) = nBackupArr(6, 5)
                            End If
                        
                            nIntChosen(6) = nArrIndx(nIndxLoop(6))
                            myShiftArrayIndx nArrIndx, nIndxLoop(6)
                            
                            nIndxLoop(7) = 1
                            bFlagArr(7) = True
                            
                            Do While nIndxLoop(7) <= 4
                                If bFlagArr(7) Then
                                    nBackupArr(7, 1) = nArrIndx(nIndxLoop(7))
                                    nBackupArr(7, 2) = nArrIndx(2)
                                    nBackupArr(7, 3) = nArrIndx(3)
                                    nBackupArr(7, 4) = nArrIndx(4)
                                    bFlagArr(7) = False
                                Else
                                    nArrIndx(1) = nBackupArr(7, 1)
                                    nArrIndx(2) = nBackupArr(7, 2)
                                    nArrIndx(3) = nBackupArr(7, 3)
                                    nArrIndx(4) = nBackupArr(7, 4)
                                End If
                            
                                nIntChosen(7) = nArrIndx(nIndxLoop(7))
                                myShiftArrayIndx nArrIndx, nIndxLoop(7)
                                
                                nIndxLoop(8) = 1
                                bFlagArr(8) = True
                                
                                Do While nIndxLoop(8) <= 3
                                    If bFlagArr(8) Then
                                        nBackupArr(8, 1) = nArrIndx(nIndxLoop(8))
                                        nBackupArr(8, 2) = nArrIndx(2)
                                        nBackupArr(8, 3) = nArrIndx(3)
                                        bFlagArr(8) = False
                                    Else
                                        nArrIndx(1) = nBackupArr(8, 1)
                                        nArrIndx(2) = nBackupArr(8, 2)
                                        nArrIndx(3) = nBackupArr(8, 3)
                                    End If

                                    nIntChosen(8) = nArrIndx(nIndxLoop(8))
                                    myShiftArrayIndx nArrIndx, nIndxLoop(8)
                                    
                                    nIndxLoop(9) = 1
                                    bFlagArr(9) = True
                                    
                                    Do While nIndxLoop(9) <= 2
                                        If bFlagArr(9) Then
                                            nBackupArr(9, 1) = nArrIndx(nIndxLoop(9))
                                            nBackupArr(9, 2) = nArrIndx(2)
                                            bFlagArr(9) = False
                                        Else
                                            nArrIndx(1) = nBackupArr(9, 1)
                                            nArrIndx(2) = nBackupArr(9, 2)
                                        End If

                                        nIntChosen(9) = nArrIndx(nIndxLoop(9))
                                        myShiftArrayIndx nArrIndx, nIndxLoop(9)
                                        
                                        nIndxLoop(10) = 1
                                        nIntChosen(10) = nArrIndx(nIndxLoop(10))
                                        
                                        nCnt = nCnt + 1
                                        
                                        strNum = ""
                                        For nLoop = 1 To nBase
                                            strNum = strNum & nIntChosen(nLoop)
                                        Next nLoop
                                        
                                        If GetPanDigitalMsg <> "" Then
                                            GetPanDigitalMsg = GetPanDigitalMsg & vbNewLine
                                        End If
                                        
                                        GetPanDigitalMsg = GetPanDigitalMsg & strNum
                                        
                                        If nCnt = 5 Then
                                            Exit Function
                                        End If
                                    
                                        nIndxLoop(9) = nIndxLoop(9) + 1
                                    Loop
                                
                                    nIndxLoop(8) = nIndxLoop(8) + 1
                                Loop
                            
                                nIndxLoop(7) = nIndxLoop(7) + 1
                            Loop
                            
                            nIndxLoop(6) = nIndxLoop(6) + 1
                        Loop
                    
                        nIndxLoop(5) = nIndxLoop(5) + 1
                    Loop
                
                    nIndxLoop(4) = nIndxLoop(4) + 1
                Loop
                
                nIndxLoop(3) = nIndxLoop(3) + 1
            Loop

            nIndxLoop(2) = nIndxLoop(2) + 1
        Loop
        
        nIndxLoop(1) = nIndxLoop(1) + 1
    Loop
    
End Function

Sub Task_01()
    
    Dim strMsg As String
    
    strMsg = "First 5 Pandigital Numbers in Base 10 are:" & vbNewLine & GetPanDigitalMsg()
    
    MsgBox strMsg, vbOKOnly, strMyTitle
    
End Sub
