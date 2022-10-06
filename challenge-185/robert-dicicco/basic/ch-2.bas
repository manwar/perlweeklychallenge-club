' AUTHOR: Robert DiCicco
' DATE: 2022-10-05
' Challenge 185 Mask Code ( Freebasic )

Dim myinput(5) As String = {"ab-cde-123", "123.abc.420", "3abc-0010.xy","1234567.a", "a-1234-bc", "a.b.c.d.e.f"}

Dim As Integer i,x,fnd,retval

Dim As String mychar

Function IsAlnum(char As String ) As Integer

   Return InStr(1,"0123456789abcdefghijklmnopqrstuvwxyz",char)

End Function

for i = 0 to 5

  fnd = 1

  for x = 1 to len(myinput(i))

    mychar = mid$(myinput(i),x,1)

    retval = IsAlnum(mychar)

    if (retval = 0 ) or ((retval <> 0) and (fnd > 4)) then

      print mychar;

    end if

    if (fnd <= 4) and ( retval <> 0 ) then

      print "x";

      fnd += 1

    end if

  next x

  print

next i
