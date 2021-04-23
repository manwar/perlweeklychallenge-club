' Challenge 105
'
' TASK #2 › The Name Game
' Submitted by: Mohammad S Anwar
' You are given a $name.
'
' Write a script to display the lyrics to the Shirley Ellis song The Name Game.
' Please checkout the wiki page for more information.
'
' Example
' Input: $name = "Katie"
' Output:
'
'     Katie, Katie, bo-batie,
'     Bonana-fanna fo-fatie
'     Fee fi mo-matie
'     Katie!

sub print_song(sName as string)
    dim sEnd as string, b as string, f as string, m as string

    sEnd = lcase(sName)
    if sEnd>="b" and sEnd<="z" _
        and left(sEnd,1)<>"e" _
        and left(sEnd,1)<>"i" _
        and left(sEnd,1)<>"o" _
        and left(sEnd,1)<>"u" then sEnd=mid(sEnd,2)
    if left(sName,1)<>"B" then b="b"
    if left(sName,1)<>"F" then f="f"
    if left(sName,1)<>"M" then m="m"

    print sName;", ";sName;", bo-";b;sEnd;","
    print "Bonana-fanna fo-";f;sEnd
    print "Fee fi mo-";m;sEnd
    print sName;"!"
end sub

print_song command(1)
