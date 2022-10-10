#!/usr/bin/env julia

# AUTHOR: Robert DiCicco
# DATE: 2022-10-10
# Challenge 186 Zip List ( Julia )

arr_a = [1,2,3]

arr_b = ["a","b","c"]

function zip( first, second)

  for x in 1:length(arr_a)

    print(string(first[x]) * " ")

    print(string(second[x]) * " ")

  end

  println(" ")

end

zip(arr_a, arr_b)

zip(arr_b, arr_a)
