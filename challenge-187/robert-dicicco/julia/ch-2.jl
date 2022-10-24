#!/usr/bin/env julia

# AUTHOR: Robert DiCicco

# DATE: 2022-10-19

# Challenge 187 Magical Triplets ( Julia )



using Combinatorics

using Printf



arr = [[1,2,3,2], [1,3,2], [1,1,2,3], [2,4,3]]



for triplet in arr

  maxval = 0;

  p = collect(permutations(triplet,3))

  for subc in p

    subc = join(subc, "")

    thisval = (parse(Int, subc))

    if (thisval > maxval)

      maxval = thisval

    end

  end

  a,b,c = split(string(maxval),"")

  a = parse(Int, a)

  b = parse(Int, b)

  c = parse(Int, c)



  @printf("Input @n = %s\n", triplet)

  if ((a+b) > c) && ((b+c)>a) && ((a+c>b))

      @printf("Output: (%d, %d, %d)\n\n",a,b,c)

  else

      @printf("Output: ()\n\n")

  end

end
