#!ruby.exe

# AUTHOR: Robert DiCicco
# DATE: 2022-05-10
# Challenge #164 Happy Numbers ( Ruby )

a = {}
Seen = {}

def SumDigitSquares(n)
  sum = 0
  a = n.digits
  a.each do |d|
    sum += d**2
  end

  if sum == 1
    return 1
  end

  if Seen.has_key?(sum)
    return 0
  end

  Seen[sum] = 1

  SumDigitSquares(sum)
end

cnt = 0
number = 1

until cnt == 8 do
  Seen.clear()
  retval = SumDigitSquares(number)
  if retval == 1
    print("#{number} ")
    cnt += 1
  end

  number += 1
end

print("\n")
