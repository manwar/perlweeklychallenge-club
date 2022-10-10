#!/usr/bin/env/julia

# AUTHOR: Robert DiCicco
# DATE:   2022-09-19
# Challenge 183 Unique Array ( Julia )

arr = ([1,2], [3,4], [5,6], [1,2]);

#arr = [9,1], [3,7], [2,5], [2,5];

display_list = ""

count = 0

println("Input:  ",arr)

print("Output: ( ")

arr_sz =size(arr,1)

for i in arr

  if count == arr_sz - 2

    print(i)

  else

    print(i,",")

  end

  global count += 1

  if count == arr_sz - 1

    break

  end

end

println(" )")
