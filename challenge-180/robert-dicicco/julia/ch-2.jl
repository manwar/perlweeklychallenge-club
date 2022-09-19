#!julia.exe

# AUTHOR: Robert DiCicco
# DATE: 2022-08-31
# Challenge #180 Trim List ( Julia )

arr = [[1,4,2,3,5],  [9,0,6,2,3,8,5]]

nums = [3,4]

count = 1

while count < 3

  results = []

  val = arr[count]

  println("Input: @n = ",val," and \$i = ",nums[count])

  chcnt = 1

  for i in val

    if i > nums[count]

      push!(results,i)

    end

  end

  global count += 1

  println("Output: ",results)

  println("")

end
