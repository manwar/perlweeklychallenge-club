#!ruby.exe

# AUTHOR: Robert DiCicco
# DATE: 2022-08-31
# Challenge 180 Trim List ( Ruby )

arr = [ [1,4,2,3,5], [9,0,6,2,3,8,5] ]

nums = [3,4]

count = 0

while count < 2

  results = []

  val = arr[count]

  puts("\nInput: @n = #{arr[count]} and $i = #{nums[count]}")

  arr[count].each do | i |

    if i >= nums[count]

      results.push(i)

    end

  end

  puts("Output: #{results}")

  count += 1

end
