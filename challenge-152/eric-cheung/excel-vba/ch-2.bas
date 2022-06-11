Attribute VB_Name = "ModTask_02"
Option Explicit

Function GetArea _
( _
    nLeftBtm_X As Integer, _
    nLeftBtm_Y As Integer, _
    nRightTop_X As Integer, _
    nRightTop_Y As Integer _
) As Integer
    GetArea = (nRightTop_X - nLeftBtm_X) * (nRightTop_Y - nLeftBtm_Y)
End Function

Function GetLength _
( _
    nLeftBtm_01 As Integer, _
    nTopRight_01 As Integer, _
    nLeftBtm_02 As Integer, _
    nTopRight_02 As Integer _
) As Integer
    If nTopRight_02 >= nTopRight_01 And nLeftBtm_02 >= nLeftBtm_01 Then
        GetLength = nTopRight_01 - nLeftBtm_02
    ElseIf nLeftBtm_02 >= nLeftBtm_01 Then
        GetLength = nTopRight_02 - nLeftBtm_01
    ElseIf nLeftBtm_01 <= nTopRight_02 And nLeftBtm_01 >= nLeftBtm_02 Then
        GetLength = Application.Min(nTopRight_01, nTopRight_02) - nLeftBtm_01
    Else
        GetLength = 0
    End If
End Function

Sub Task_02()

    ''========== Example 1 ==========
    ''========== Rectangle 1 ==========
    Const nRec_01_LeftBtm_X As Integer = -1
    Const nRec_01_LeftBtm_Y As Integer = 0

    Const nRec_01_RightTop_X As Integer = 2
    Const nRec_01_RightTop_Y As Integer = 2
    ''========== Rectangle 1 ==========


    ''========== Rectangle 2 ==========
    Const nRec_02_LeftBtm_X As Integer = 0
    Const nRec_02_LeftBtm_Y As Integer = -1

    Const nRec_02_RightTop_X As Integer = 4
    Const nRec_02_RightTop_Y As Integer = 4
    ''========== Rectangle 2 ==========
    ''========== Example 1 ==========
    
''    ''========== Example 2 ==========
''    ''========== Rectangle 1 ==========
''    Const nRec_01_LeftBtm_X As Integer = -3
''    Const nRec_01_LeftBtm_Y As Integer = -1
''
''    Const nRec_01_RightTop_X As Integer = 1
''    Const nRec_01_RightTop_Y As Integer = 3
''    ''========== Rectangle 1 ==========
''
''
''    ''========== Rectangle 2 ==========
''    Const nRec_02_LeftBtm_X As Integer = -1
''    Const nRec_02_LeftBtm_Y As Integer = -3
''
''    Const nRec_02_RightTop_X As Integer = 2
''    Const nRec_02_RightTop_Y As Integer = 2
''    ''========== Rectangle 2 ==========
''    ''========== Example 2 ==========
    
    Dim nResult As Integer
    
    nResult = _
    GetArea(nRec_01_LeftBtm_X, nRec_01_LeftBtm_Y, nRec_01_RightTop_X, nRec_01_RightTop_Y) _
    + GetArea(nRec_02_LeftBtm_X, nRec_02_LeftBtm_Y, nRec_02_RightTop_X, nRec_02_RightTop_Y) _
    - GetLength(nRec_01_LeftBtm_X, nRec_01_RightTop_X, nRec_02_LeftBtm_X, nRec_02_RightTop_X) _
    * GetLength(nRec_01_LeftBtm_Y, nRec_01_RightTop_Y, nRec_02_LeftBtm_Y, nRec_02_RightTop_Y)

    MsgBox nResult, vbOKOnly, strMyTitle
    
End Sub
