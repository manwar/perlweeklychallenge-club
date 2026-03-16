Function convert_to_digits(text as String) as String
    Dim result as String, i as Integer, c as String

    For i = 1 To Len(text)
        c = Mid(text, i, 1)
        if c >= "a" And c <= "z" Then
            result = result & Str(Asc(c) - Asc("a") + 1)
            result = Trim(result)
        End If
    Next

    convert_to_digits = result
End Function

Function sum_digits(text as String) as Integer
    Dim sum as Integer, i as Integer, c as String

    sum = 0
    For i = 1 To Len(text)
        c = Mid(text, i, 1)
        if c >= "0" And c <= "9" Then
            sum = sum + Val(c)
        End If
    Next

    sum_digits = sum
End Function

Function compute(text as String, k as Integer) as Integer
    Dim digits as String, i as Integer, sum as Integer

    digits = convert_to_digits(text)
    For i = 1 To k
        sum = sum_digits(digits)
        digits = Trim(Str(sum))
    Next

    compute = sum
End Function

Print compute(Command(1), Val(Command(2)))
