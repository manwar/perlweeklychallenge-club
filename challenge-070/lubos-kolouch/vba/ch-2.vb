Sub GrayCode()
    Dim N As Integer
    N = 4
    Dim grayCode As New Collection
    grayCode.Add "0"
    grayCode.Add "1"

    Dim i As Integer
    For i = 2 To N
        Dim revGrayCode As New Collection
        Dim j As Integer
        For j = grayCode.Count To 1 Step -1
            revGrayCode.Add "1" & grayCode(j)
        Next j
        For j = 1 To grayCode.Count
            grayCode(j) = "0" & grayCode(j)
        Next j
        For j = 1 To revGrayCode.Count
            grayCode.Add revGrayCode(j)
        Next j
    Next i

    For i = 1 To grayCode.Count
        Debug.Print CStr(CLng("&B" & grayCode(i))) & " ";
    Next i
End Sub
