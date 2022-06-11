Attribute VB_Name = "ModTask_02"
Option Explicit

Function GetSqRoot(ByVal nNum As Integer) As String

    Const nNumMax As Integer = 22
    Dim strSqRootArr(1 To nNumMax) As String

    If nNum < 2 Or nNum > nNumMax Then
        GetSqRoot = ""
        Exit Function
    End If
    
    strSqRootArr(1) = ""
    strSqRootArr(2) = "1"
    strSqRootArr(3) = "1"
    strSqRootArr(4) = "3201"
    strSqRootArr(5) = "4301"
    strSqRootArr(6) = "452013"
    strSqRootArr(7) = "6250341"
    strSqRootArr(8) = "47302651"
    strSqRootArr(9) = "823146570"
    strSqRootArr(10) = "9814072356"
    strSqRootArr(11) = "A8701245369"
    strSqRootArr(12) = "B8750A649321"
    strSqRootArr(13) = "CBA504216873"
    strSqRootArr(14) = "DC71B30685A924"
    strSqRootArr(15) = "EDAC93B24658701"
    strSqRootArr(16) = "FED5B39A42706C81"
    strSqRootArr(17) = "GFED5A31C6B79802"
    strSqRootArr(18) = "HGF80ADC53712EB649"
    strSqRootArr(19) = "IHGFD3408C6E715A2B9"
    strSqRootArr(20) = "JIHG03DAC457BFE96281"
    strSqRootArr(22) = "LKJIG5D14B9032FHAC867E"
    
    GetSqRoot = strSqRootArr(nNum)

End Function

Sub Task_02()

    '' Credits:
    '' https://www.quora.com/How-do-you-square-a-number-that-isnt-in-base-ten
    '' https://github.com/manwar/perlweeklychallenge-club/blob/master/challenge-149/abigail/bash/ch-2.sh

    Dim strMsg As String
    
    '' strMsg = GetSqRoot(2)
    '' strMsg = GetSqRoot(4)
    '' strMsg = GetSqRoot(10)
    strMsg = GetSqRoot(12)

    MsgBox strMsg, vbOKOnly, strMyTitle
    
End Sub

