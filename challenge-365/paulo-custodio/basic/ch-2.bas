Function is_letter(c as String) as Boolean
    is_letter = c >= "a" And c <= "z"
End Function

Function is_punct(c as String) as Boolean
    is_punct = c = "!" Or c = "." Or c = ","
End Function

Function is_valid(text as String) as Boolean
    Dim has_hiffen as Boolean, i as Integer, c as String, p as String, n as String

    has_hiffen = False
    For i = 1 To Len(text)
        c = Mid(text, i, 1)
        If is_letter(c) Then
            ' ok
        ElseIf c = "-" Then
            If has_hiffen Then
                is_valid = False
                Exit Function
            End If
            has_hiffen = True

            If i = 1 Or i = Len(text) Then
                is_valid = False
                Exit Function
            End If

            p = Mid(text, i-1, 1)
            n = Mid(text, i+1, 1)

            If Not is_letter(p) Or Not is_letter(n) Then
                is_valid = False
                Exit Function
            End If
        ElseIf is_punct(c) And i = Len(text) Then
            ' ok
        Else
            is_valid = False
            Exit Function
        End If
    Next

    is_valid = True
End Function

Function count_valid as Integer
    Dim i as Integer, count as Integer

    count = 0
    i = 1
    Do While Command(i) <> ""
        If is_valid(Command(i)) Then
            count = count + 1
        End If
        i = i + 1
    Loop

    count_valid = count
End Function

print count_valid()
