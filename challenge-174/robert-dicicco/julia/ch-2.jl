#!julia.exe

# AUTHOR: Robert DiCicco
# DATE: 2022-07-20
# Challenge 174 Permutation Ranking ( Julia )

using Combinatorics

p = []                                    # holder for permutations

function rank2permutation( lst, x  )      # given a list, create all permutations, and return index x

  createPermList(lst)

  return(p[x + 1])

end

function permutation2rank( lst )          # given a list, return its index in permutations

  for x in 1:length(p)

    if p[x] == lst

      return x - 1

    end

  end

end

function createPermList(lst)             # create all permutations of lst

    global p = collect(permutations(lst))

end

mylist = [0,1,2]

createPermList(mylist)

println(p)

x = [1,0,2]

retval = permutation2rank(x)

println("permutation2rank(" * string(x) * " = " * string(retval))

println(" ")

x = [0,1,2]

tofind = 1

retval = rank2permutation(x, 1)

println(p)

str = "rank2permutation(" * string(x) * ", " * string(tofind) * " ) = " * string(retval)

println(str)
