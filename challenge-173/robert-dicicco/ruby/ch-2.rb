#!ruby.exe

# AUTHOR: Robert DiCicco
# DATE: 2022-07-13
# Challenge 173 Sylvbester's Sequence ( Ruby )

arr =[2]

count = 1

puts arr

while true

  prod = arr.inject(:*) + 1

  puts prod

  arr.push(prod)

  count += 1

  if count == 10

    break

  end

end
