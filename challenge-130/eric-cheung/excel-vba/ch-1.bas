Attribute VB_Name = "ModTask_01"
Option Explicit
Public Const strMyTitle As String = "Eric Cheung"

Sub Task_01()

    ''Credit: https://www.mrexcel.com/board/threads/vba-count-number-of-occurances-in-an-array.636537/

    Dim strMsg As String
    Dim arrNum() As Variant, objDict As Object, objVar As Variant
    Dim nLoop As Integer
    
    ''arrNum = Array(2, 5, 4, 4, 5, 5, 2)
    arrNum = Array(1, 2, 3, 4, 3, 2, 1, 4, 4)

    Set objDict = CreateObject("Scripting.Dictionary")
    
    For nLoop = LBound(arrNum) To UBound(arrNum)
        If objDict.exists(arrNum(nLoop)) Then
            objDict.Item(arrNum(nLoop)) = objDict.Item(arrNum(nLoop)) + 1
        Else
            objDict.Add arrNum(nLoop), 1
        End If
    Next nLoop
    
    For Each objVar In objDict.keys
        If objDict.Item(objVar) Mod 2 = 1 Then
            If strMsg <> "" Then
                strMsg = strMsg & ", "
            End If
            strMsg = strMsg & objVar
        End If
    Next objVar
    
    Set objDict = Nothing

    MsgBox strMsg, vbOKOnly, strMyTitle
    
End Sub
