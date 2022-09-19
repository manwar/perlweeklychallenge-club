#!/usr/bin/env julia
# Perl weekly challenge 177
# Task 2: Palyndromic prime cyclops
#
# See https://wlmb.github.io/2022/08/08/PWC177/#task-2-palindromic-prime-cyclops
using Primes
let left=1
    count=0
    howmany=if isempty(ARGS) 20 else parse(Int64,ARGS[1]) end
    while(count<howmany)
        leftstring=string(left)
        if !occursin("0", leftstring)
            candidate=parse(Int64, leftstring*"0"*reverse(leftstring))
            if isprime(candidate)
                count +=1
                print("$candidate ")
            end
        end
        left += 1
    end
end
