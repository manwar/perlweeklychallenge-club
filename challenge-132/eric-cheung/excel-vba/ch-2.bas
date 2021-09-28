Attribute VB_Name = "ModTask_02"
Option Explicit
Option Base 1

Sub Task_02()
    ''https://stackoverflow.com/questions/10951687/how-to-search-for-string-in-an-array
    ''https://www.automateexcel.com/vba/find-value-in-array/
    ''https://www.excelfunctions.net/vba-filter-function.html

    Dim strMsg As String
    Dim arrAge As Variant, arrName As Variant
    Dim arrFirstName As Variant, arrSurName As Variant, arrFullName As Variant
    Dim arrTemp As Variant
    Dim nLoop As Integer, nSubLoop As Integer

    ReDim arrFullName(1 To 1)

    arrAge = Array(20, 28, 38, 18, 25, 18)
    arrName = Array("Alex", "Joe", "Mike", "Alex", "David", "Simon")

    arrFirstName = Array("Alex", "Joe", "Mike", "Joe", "Alex", "Simon")
    arrSurName = Array("Stewart", "Root", "Gatting", "Blog", "Jones", "Duane")
    
    For nLoop = LBound(arrFirstName) To UBound(arrFirstName)
        If nLoop > 1 Then
            ReDim Preserve arrFullName(1 To nLoop)
        End If
        arrFullName(nLoop) = arrFirstName(nLoop) & ", " & arrSurName(nLoop)
    Next nLoop

    For nLoop = LBound(arrName) To UBound(arrName)
        arrTemp = Filter(arrFullName, arrName(nLoop))
        If UBound(arrTemp) - LBound(arrTemp) + 1 > 0 Then
            For nSubLoop = LBound(arrTemp) To UBound(arrTemp)
                If strMsg <> "" Then
                    strMsg = strMsg & vbNewLine
                End If
                strMsg = strMsg & arrAge(nLoop) & ", " & arrTemp(nSubLoop)
            Next nSubLoop
            Erase arrTemp
        End If
    Next nLoop

    MsgBox strMsg, vbOKOnly, strMyTitle
    
End Sub

