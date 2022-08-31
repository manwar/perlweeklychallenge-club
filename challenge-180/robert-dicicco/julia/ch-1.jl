#!julia.exe

using DataStructures

# AUTHOR: Robert DiCicco
# DATE: 2022-08-31
# Challenge #180 First Unique Character ( Julia )

arr = ["Perl Weekly Challenge", "Long Live Perl" ]

nums = [3,4]

count = 1

LetterCnt = OrderedDict()

function mysetup( s )

  Letters = split(s,"")

  for ch in Letters

    if haskey(LetterCnt, ch)

      LetterCnt[ch] += 1

    else

      LetterCnt[ch] = 1

    end

  end

  offset = 0

  for ch in Letters

     if LetterCnt[ch] == 1

       println("Output: " * string(offset) * " as \'" * ch * "\' is the first unique character")

       println(" ")

       break

     end

     offset += 1

  end

end

for str in arr

  print("Input: \$s = \"" * str * "\"\n")

  mysetup(str)

  global count += 1

end
