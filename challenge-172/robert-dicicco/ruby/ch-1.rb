#!ruby.exe

# AUTHOR: Robert DiCicco
# DATE: 2022-07-05
# Challenge 172 Prime Partition ( Ruby )

require 'prime'

arr = []                        # array to hold primes
result = []                     # array to hold results

m = ARGV[0].to_i                # number to test

n = ARGV[1].to_i                # how many primes to sum

(1..m).each { |p|               # get primes <= number to test

  if(Prime.prime?(p))

    arr.push(p)                 # save it to arr

  end

}

perm = arr.permutation(n).to_a    # get permutations of length n from arr

perm.each { |subperm|             # get sum of each perm

  sum = 0

  (0..n).each { |ndx|

    sum += subperm[ndx].to_i

  }

  if(sum == m)                    # if sum equals number to test

    result.push(subperm.sort)     # save sorted perm to result

  end

}

print("$m = #{m} $n = #{n}\n")

print(result.uniq)                # remove all dup perms

puts(" ")
