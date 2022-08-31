#!ruby.exe

# AUTHOR: Robert DiCicco
# DATE: 2022-08-31
# Challenge #180 First Unique Character ( Ruby )

strs = [ 'Long Live Perl','Perl Weekly Challenge' ]

count = 0

nums = [3,4]

 def mysetup( str )

  letters = Hash.new(0)

  chars = str.split('')

  chars.each do |x|

    if letters.has_key?(x)

      letters[x] += 1

    else

      letters[x] = 1

    end

  end

  offset = 0

  chars.each do |x|

    if letters[x] == 1

      puts("Output: #{offset} as \'#{x}\' is the first unique character")

      puts(" ")

      break

    end

    offset += 1

  end

end

while count < 2

  puts("Input: $s = \"#{strs[count]}\"\n");

  mysetup(strs[count])

  count += 1

end
