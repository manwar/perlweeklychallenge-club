Attribute VB_Name = "ModTask_01"
Option Explicit
Public Const strMyTitle As String = "Eric Cheung"

Function IsPerfectSq(nNum As Integer) As Boolean
    If Sqr(nNum) - Int(Sqr(nNum)) = 0 Then
        IsPerfectSq = True
        Exit Function
    End If
    IsPerfectSq = False
End Function

Sub SortNum(ByRef nNum_01 As Integer, ByRef nNum_02 As Integer, Optional bSortAscOrder As Boolean = True)
    Dim nTempNum As Integer
    If _
        bSortAscOrder And nNum_01 > nNum_02 _
        Or Not bSortAscOrder And nNum_01 < nNum_02 _
    Then
        nTempNum = nNum_01
        nNum_01 = nNum_02
        nNum_02 = nTempNum
    End If
End Sub

Sub Task_01()
    ''https://www.cuemath.com/geometry/pythagorean-triples/
    
    Dim nInput As Integer, nTemp As Integer
    Dim nTriple_01 As Integer, nTriple_02 As Integer, nTriple_03 As Integer
    Dim nTriple_04 As Integer, nTriple_05 As Integer, nTriple_06 As Integer
    Dim nTriple_07 As Integer, nTriple_08 As Integer, nTriple_09 As Integer
    Dim strMsg As String
    Dim bFlag_01 As Boolean, bFlag_02 As Boolean
    
    nInput = 5
    
    '======================= SET 1, IF APPLICABLE =======================
    nTriple_01 = nInput
    
    If nInput Mod 2 = 0 Then
        nTriple_02 = nInput * nInput / 4 - 1
        nTriple_03 = nInput * nInput / 4 + 1
    Else
        nTriple_02 = nInput * nInput / 2 - 0.5
        nTriple_03 = nInput * nInput / 2 + 0.5
    End If
    
    If nTriple_02 = 0 Then
        MsgBox -1, vbOKOnly, strMyTitle
        Exit Sub
    End If

    SortNum nTriple_01, nTriple_02
    
    strMsg = "Set 1 Triple: " & nTriple_01 & ", " & nTriple_02 & ", " & nTriple_03
    '======================= SET 1, IF APPLICABLE =======================
    
    '======================= SET 2, IF APPLICABLE =======================
    bFlag_01 = False
    nTemp = (nInput + 1) * 4
    If IsPerfectSq(nTemp) Then
        nTriple_04 = Sqr(nTemp)
        nTriple_05 = nInput
        nTriple_06 = nInput + 2
        
        bFlag_01 = True
    End If
    
    If Not bFlag_01 Then
        nTemp = (nInput + 0.5) * 2
        If IsPerfectSq(nTemp) Then
            nTriple_04 = Sqr(nTemp)
            nTriple_05 = nInput
            nTriple_06 = nInput + 1
            
            bFlag_01 = True
        End If
    End If
    
    If bFlag_01 Then
        SortNum nTriple_04, nTriple_05
    End If
    
    If bFlag_01 Then
        'Same Set
        If _
            nTriple_01 = nTriple_04 _
            And nTriple_02 = nTriple_05 _
        Then
            bFlag_01 = False
        End If
    End If
    
    If bFlag_01 Then
        strMsg = strMsg & vbNewLine & "Set 2 Triple: " & nTriple_04 & ", " & nTriple_05 & ", " & nTriple_06
    End If
    '======================= SET 2, IF APPLICABLE =======================
    
    '======================= SET 3, IF APPLICABLE =======================
    bFlag_02 = False
    
    nTemp = (nInput - 1) * 4
    If IsPerfectSq(nTemp) Then
        nTriple_07 = Sqr(nTemp)
        nTriple_08 = nInput - 2
        nTriple_09 = nInput
        
        bFlag_02 = True
    End If
    
    If Not bFlag_02 Then
        nTemp = (nInput - 0.5) * 2
        If IsPerfectSq(nTemp) Then
            nTriple_07 = Sqr(nTemp)
            nTriple_08 = nInput - 1
            nTriple_09 = nInput
            
            bFlag_02 = True
        End If
    End If
    
    If bFlag_02 Then
        SortNum nTriple_07, nTriple_08
    End If
    
    If bFlag_02 Then
        strMsg = strMsg & vbNewLine
        If bFlag_01 Then
            strMsg = strMsg & "Set 3 Triple: "
        Else
            strMsg = strMsg & "Set 2 Triple: "
        End If
        strMsg = strMsg & nTriple_07 & ", " & nTriple_08 & ", " & nTriple_09
    End If
    '======================= SET 3, IF APPLICABLE =======================
    
    MsgBox strMsg, vbOKOnly, strMyTitle
    
End Sub
