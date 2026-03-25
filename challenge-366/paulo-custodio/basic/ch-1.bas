' Perl Weekly Challenge 366 - Task 1 - solution by Paulo Custodio
' https://theweeklychallenge.org/blog/perl-weekly-challenge-366/

Function is_prefix(word as String, prefix as String) as Boolean
    If Len(word) >= Len(prefix) And prefix = Left(word, Len(prefix)) Then
        is_prefix = True
    Else
        is_prefix = False
    End If
End Function

Dim word as String, i as Integer, count as Integer

word = Command(1)
For i = 2 To __FB_ARGC__-1
    If is_prefix(word, Command(i)) Then
        count = count + 1
    End If
Next i

Print count
