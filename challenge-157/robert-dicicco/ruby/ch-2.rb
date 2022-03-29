#!ruby.exe

# AUTHOR: Robert DiCicco
# DATE: 22-MAR-2022
# Challenge 157 Brazilian Number ( Ruby )

def checkDigits( n )
  arr = n.to_s.chars.map(&:to_i)
  digit = arr[0]

  for i in (0..(arr.size-1)) do
    return 0 if(arr[i] != digit)
  end

  return 1
end

num = ARGV[0].to_i
puts "Input: #{num}"

for h in 2..(num-2) do
  flag = 0
  x = num.to_s(h)
  puts "In base #{h}: #{x}"
  retval = checkDigits(x)

  if (retval == 1)
    flag = 1
    puts "Output: #{retval}"
    break
  end
end

if ( flag == 0 )
  puts "Output: 0"
end
