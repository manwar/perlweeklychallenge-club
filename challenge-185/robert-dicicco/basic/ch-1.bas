' AUTHOR: Robert DiCicco
' DATE: 2022-10-05
' Challenge 185 Mac Address ( Freebasic )

Dim myinput(2) As String = {"1ac2.34f0.b1c2","abc1.20f1.345a"}

Dim As Integer i,x,z,cnt

Dim  As String s, mychar, outstr

for i = 0 to 1

  cnt = 0

  for z = 1 to 14

    mychar = mid$(myinput(i),z,1)

    if (mychar = ".") then

      continue for

    end if

    outstr += mychar

    cnt += 1

    if (cnt = 2) then

      outstr += ":"

      cnt = 0

    end if

  next z

  print RTrim(outstr, ":")

  outstr = ""

next i
