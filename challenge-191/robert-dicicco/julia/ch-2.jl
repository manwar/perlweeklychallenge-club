#!/usr/bin/env julia



#=

AUTHOR: Robert DiCicco

DATE: 2022-11-17

Challenge 191 Cute List ( Julia )



You are given an integer, 0 < $n <= 15.



Write a script to find the number of orderings of numbers that form a cute list.



With an input @list = (1, 2, 3, .. $n) for positive integer $n, an ordering of @list is cute if for every entry, indexed with a base of 1, either



1) $list[$i] is evenly divisible by $i

or

2) $i is evenly divisible by $list[$i]



Example



Input: $n = 2

Ouput: 2



Since $n = 2, the list can be made up of two integers only i.e. 1 and 2.

Therefore we can have two list i.e. (1,2) and (2,1).



@list = (1,2) is cute since $list[1] = 1 is divisible by 1 and $list[2] = 2 is divisible by 2.

=#



using Combinatorics

using Printf



function checkArgs(args)

  global num

  try

    num = parse(Int64, args)

  catch

    println("Error: Argument must be an integer")

    exit(0)

  finally

    if num < 1 || num > 15

      println("Error: Argument must be > 0 and less than 16")

      exit(0)

    else

      main(num)

    end

  end

end



function main(arg)

arr = collect(1:arg)

@printf("\n\nInput: %s\n", arg)

p = collect(permutations(arr,length(arr)))

for suba in p

  res = 0

  res2 = 0

  success = 0

  for x in 1:length(suba)

    res = suba[x] % x

    res2 = x % suba[x]

    if ((res == 0) || (res2 == 0) )

      success += 1

    end

    if success == length(suba)

      @printf("%s is cute!\n", suba)

    end

  end

end

end



for mynum in ARGS

  checkArgs(mynum)

end



#=

SAMPLE OUTPUT

julia .\CuteList.jl 2 3 4

Input: 2

[1, 2] is cute!

[2, 1] is cute!



Input: 3

[1, 2, 3] is cute!

[2, 1, 3] is cute!

[3, 2, 1] is cute!



Input: 4

[1, 2, 3, 4] is cute!

[1, 4, 3, 2] is cute!

[2, 1, 3, 4] is cute!

[2, 4, 3, 1] is cute!

[3, 2, 1, 4] is cute!

[3, 4, 1, 2] is cute!

[4, 1, 3, 2] is cute!

[4, 2, 3, 1] is cute!

=#
