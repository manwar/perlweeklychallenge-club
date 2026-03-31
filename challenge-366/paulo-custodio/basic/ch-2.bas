' Perl Weekly Challenge 366 - Task 2 - solution by Paulo Custodio
' https://theweeklychallenge.org/blog/perl-weekly-challenge-366/

Function count_minutes(t as String) as Integer
    Dim h1 as String, h2 as String, m1 as String, m2 as String
    Dim hours as Integer, minutes as Integer

    If Len(t) <> 5 Or Mid(t,3,1) <> ":" Then
        count_minutes = 0
    Else
        h1 = Mid(t,1,1)
        h2 = Mid(t,2,1)
        m1 = Mid(t,4,1)
        m2 = Mid(t,5,1)

        If h1 = "?" And h2 = "?" Then
            hours = 24
        ElseIf h1 = "?" Then
            If h2 <= "9" Then hours = hours + 2
            If h2 <= "3" Then hours = hours + 1
        ElseIf h2 = "?" Then
            If h1 = "0" Or h1 = "1" Then hours = 10 Else hours = 4
        Else
            If Val(t) <= 23 Then hours = 1 Else hours = 0
        End If

        If m1 = "?" Then minutes = 6 Else minutes = 1
        If m2 = "?" Then minutes = minutes * 10

        count_minutes = hours * minutes
    End If
End Function

Print count_minutes(Command(1))
