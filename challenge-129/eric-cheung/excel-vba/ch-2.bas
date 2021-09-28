Attribute VB_Name = "ModTask_02"
Option Explicit
Option Base 1

Sub Task_02()

    Dim strMsg As String
    Dim nCnt As Integer
    
    Dim nArrLink_01() As Variant, nArrLink_02() As Variant
    Dim nArrAddLink() As Integer
    Dim nLoop_01 As Integer, nLoop_02 As Integer, nLoop As Integer
    Dim nQuotient As Integer, nRemainder As Integer, nTemp As Integer, nMax As Integer
    Dim bFlag As Boolean
    
    ReDim nArrAddLink(1 To 1)

    ''nArrLink_01 = Array(1, 2, 3)
    ''nArrLink_02 = Array(3, 2, 1)
    
    nArrLink_01 = Array(1, 2, 3, 4, 5)
    nArrLink_02 = Array(6, 5, 5)
    
    nLoop_01 = UBound(nArrLink_01) - LBound(nArrLink_01) + 1
    nLoop_02 = UBound(nArrLink_02) - LBound(nArrLink_02) + 1
    
    bFlag = False
    
    nQuotient = 0
    nRemainder = 0
    nCnt = 0
    
    Do While (nLoop_01 >= 1 And nLoop_02 >= 1)
    
        nTemp = nArrLink_01(nLoop_01) + nArrLink_02(nLoop_02) + nQuotient
        nQuotient = Int(nTemp / 10)
        nRemainder = nTemp Mod 10
        
        nCnt = nCnt + 1
        
        If bFlag Then
            ReDim Preserve nArrAddLink(1 To nCnt)
        Else
            bFlag = True
        End If
        
        nArrAddLink(nCnt) = nRemainder
    
        nLoop_01 = nLoop_01 - 1
        nLoop_02 = nLoop_02 - 1
    Loop
    
    Do While (nLoop_01 >= 1)
    
        nTemp = nArrLink_01(nLoop_01) + nQuotient
        nQuotient = Int(nTemp / 10)
        nRemainder = nTemp Mod 10
        
        nCnt = nCnt + 1
        
        If bFlag Then
            ReDim Preserve nArrAddLink(1 To nCnt)
        Else
            bFlag = True
        End If
        
        nArrAddLink(nCnt) = nRemainder
    
        nLoop_01 = nLoop_01 - 1
    Loop
    
    Do While (nLoop_02 >= 1)
    
        nTemp = nArrLink_02(nLoop_02) + nQuotient
        nQuotient = Int(nTemp / 10)
        nRemainder = nTemp Mod 10
        
        nCnt = nCnt + 1
        
        If bFlag Then
            ReDim Preserve nArrAddLink(1 To nCnt)
        Else
            bFlag = True
        End If
        
        nArrAddLink(nCnt) = nRemainder

        nLoop_02 = nLoop_02 - 1
    Loop
    
    If nCnt Mod 2 = 0 Then
        nMax = nCnt / 2
    Else
        nMax = (nCnt - 1) / 2
    End If
    
    For nLoop = 1 To nMax
        nTemp = nArrAddLink(nLoop)
        nArrAddLink(nLoop) = nArrAddLink(nCnt - nLoop + 1)
        nArrAddLink(nCnt - nLoop + 1) = nTemp
    Next nLoop
    
    For nLoop = 1 To nCnt
        If strMsg <> "" Then
            strMsg = strMsg & ", "
        End If
        strMsg = strMsg & nArrAddLink(nLoop)
    Next nLoop

    MsgBox strMsg, vbOKOnly, strMyTitle
    
End Sub
