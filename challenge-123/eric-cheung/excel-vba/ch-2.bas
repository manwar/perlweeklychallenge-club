Attribute VB_Name = "ModTask_02"
Option Explicit

Function DistSq _
( _
    nX_01 As Double, _
    nY_01 As Double, _
    nX_02 As Double, _
    nY_02 As Double _
) As Double
    DistSq = (nX_01 - nX_02) ^ 2 + (nY_01 - nY_02) ^ 2
End Function

Function IsRightAngle _
( _
    nX_01 As Double, _
    nY_01 As Double, _
    nX_02 As Double, _
    nY_02 As Double, _
    nX_03 As Double, _
    nY_03 As Double _
) As Boolean

    IsRightAngle = False

    Dim m_01 As Double, m_02 As Double
    
    If nX_02 = nX_03 Then
        If nY_01 = nY_02 Then
            IsRightAngle = True
        End If
        Exit Function
    End If
    
    If nX_01 = nX_02 Then
        If nY_02 = nY_03 Then
            IsRightAngle = True
        End If
        Exit Function
    End If
    
    m_01 = (nY_01 - nY_02) / (nX_01 - nX_02)
    m_02 = (nY_02 - nY_03) / (nX_02 - nX_03)
    
    If m_01 * m_02 = -1 Then
        IsRightAngle = True
        Exit Function
    End If

End Function

Sub Task_02()

    Const nNumPt As Integer = 4
    Dim nX_Pt(1 To nNumPt) As Double
    Dim nY_Pt(1 To nNumPt) As Double
    
    Dim bIsSq As Boolean
    Dim strMsg As String
    
    bIsSq = False
    
''    nX_Pt(1) = 10: nX_Pt(2) = 20: nX_Pt(3) = 20: nX_Pt(4) = 10
''    nY_Pt(1) = 20: nY_Pt(2) = 20: nY_Pt(3) = 10: nY_Pt(4) = 10
    
    nX_Pt(1) = 12: nX_Pt(2) = 16: nX_Pt(3) = 20: nX_Pt(4) = 18
    nY_Pt(1) = 24: nY_Pt(2) = 10: nY_Pt(3) = 12: nY_Pt(4) = 16
    
    If _
        DistSq(nX_Pt(1), nX_Pt(2), nY_Pt(1), nY_Pt(2)) = DistSq(nX_Pt(2), nX_Pt(3), nY_Pt(2), nY_Pt(3)) _
        And DistSq(nX_Pt(2), nX_Pt(3), nY_Pt(2), nY_Pt(3)) = DistSq(nX_Pt(3), nX_Pt(4), nY_Pt(3), nY_Pt(4)) _
        And DistSq(nX_Pt(3), nX_Pt(4), nY_Pt(3), nY_Pt(4)) = DistSq(nX_Pt(4), nX_Pt(1), nY_Pt(4), nY_Pt(1)) _
        And IsRightAngle(nX_Pt(1), nY_Pt(1), nX_Pt(2), nY_Pt(2), nX_Pt(3), nY_Pt(3)) _
        And IsRightAngle(nX_Pt(2), nY_Pt(2), nX_Pt(3), nY_Pt(3), nX_Pt(4), nY_Pt(4)) _
        And IsRightAngle(nX_Pt(4), nY_Pt(4), nX_Pt(1), nY_Pt(1), nX_Pt(2), nY_Pt(2)) _
    Then
        bIsSq = True
    End If
    
    strMsg = "0 as the given coordinates doesn't form a square."
    If bIsSq Then
        strMsg = "1 as the given coordinates form a square."
    End If
    
    MsgBox strMsg, vbOKOnly, strMyTitle
    
End Sub

