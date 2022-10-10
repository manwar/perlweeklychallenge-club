#!/usr/bin/env/ ruby

# AUTHOR: Robert DiCicco
# DATE: 2022-10-10
# Challenge 186 Zip List ( Ruby )

arr_a = [1,2,3]

arr_b = ["a","b","c"]

def zip ( first, second )

  if first.length != second.length then

    puts "Error: Uneven arrays!"

    exit -1

  end

  for x in 0..first.length - 1 do

    print first[x].to_s + " "

    print second[x].to_s + " "

  end

  puts " "

end

zip(arr_a,arr_b)

zip(arr_b,arr_a)
