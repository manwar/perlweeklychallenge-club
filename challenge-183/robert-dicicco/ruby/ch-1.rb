#!ruby.exe

# AUTHOR: Robert DiCicco
# DATE:   2022-09-19
# Challenge 183 Unique Array ( Ruby )

@list = [1,2], [3,4], [5,6], [1,2];

#@list = [9,1], [3,7], [2,5], [2,5];

list_uniq = Hash.new

display_list = ""

print("Input: ( #{@list}\n")

print("Output: ( ")

count = 1

@list.each do |x|

  display_list = display_list.to_s + x.inspect.to_s

  if ! list_uniq.has_key?(x)

    list_uniq[x] = 1

    if count == @list.count - 1

      print("#{x}")

    else

      print("#{x},")

    end

    count += 1

  end

end

puts(" \)")
