#!/usr/bin/env ruby

=begin

----------------------------------------------

AUTHOR: Robert DiCicco

DATE  : 2022-12-20

Challenge 196 Pattern 132 ( Ruby )

SAMPLE OUTPUT

ruby .\Pattern132.rb

 

Input: @list = [3, 1, 4, 2]

Output: [1, 4, 2]

 

Input: @list = [1, 2, 3, 4]

Output: -1

 

Input: @list = [1, 3, 2, 4, 6, 5]

Output: [1, 3, 2]

 

Input: @list = [1, 3, 4, 2]

Output: [1, 3, 2]

----------------------------------------------

=end

 

lists = [[3, 1, 4, 2],[1, 2, 3, 4],[1, 3, 2, 4, 6, 5],[1, 3, 4, 2]]

 

def findFirst(arr)

  $out = Array.new

  for fi in 0..arr.length() - 1

    if arr[fi] == 1

      $out.push(arr[fi])

      return fi

    end

  end

  return -1

end

 

def findSecond(arr, fi)

  fi += 1

  while ( fi < arr.length() - 1)

    if arr[fi] >= 3

      $out.push(arr[fi])

      return fi

    end

    fi += 1

  end

  return -1

end

 

def findThird(arr, fi)

  fi += 1

  while (fi <= arr.length() - 1)

    if arr[fi] !~ /\D/

      if arr[fi] < $out[1]

        $out.push(arr[fi])

      end

    end

    fi += 1

  end

 return -1

end

 

lists.each do |list|

  $out = ()

  puts("\nInput: @list = #{list}")

  retval = findFirst(list);

  secval = findSecond(list, retval);

  thirdval = findThird(list, secval)

  if $out.length == 3

    puts("Output: #{$out}")

  else

    puts("Output: -1")

  end

end
