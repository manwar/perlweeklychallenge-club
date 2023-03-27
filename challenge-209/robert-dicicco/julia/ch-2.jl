#!/usr/bin/env julia
#=
------------------------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-03-26
Challenge 209 Merge Account ( Julia )
------------------------------------------------------
=#

using Printf

accounts = [["A", "a1@a.com", "a2@a.com"], ["B", "b1@b.com"], ["A", "a3@a.com", "a1@a.com"]]
#accounts = [ ["A", "a1@a.com", "a2@a.com"], ["B", "b1@b.com"], ["A", "a3@a.com"], ["B", "b2@b.com", "b1@b.com"] ]

a = []
b = []
@printf("Input: @accounts = %s\n", accounts)
for sub in accounts
    if sub[1] == "A"
        for x in sub
            push!(a,x)
        end
    elseif sub[1] == "B"
        for x in sub
            push!(b,x)
        end
    end
end
@printf("\t%s\n",unique(sort(a)))
@printf("\t%s\n",unique(sort(b)))
println(" ")

#=
------------------------------------------------------
julia .\MergeAccount.jl
Input: @accounts = [["A", "a1@a.com", "a2@a.com"], ["B", "b1@b.com"], ["A", "a3@a.com", "a1@a.com"]]
        Any["a1@a.com", "a2@a.com", "a3@a.com"]
        Any["b1@b.com"]

PS G:\Projects\Perl\Challenges> julia .\MergeAccount.jl
Input: @accounts = [["A", "a1@a.com", "a2@a.com"], ["B", "b1@b.com"], ["A", "a3@a.com"], ["B", "b2@b.com", "b1@b.com"]]
        Any["a1@a.com", "a2@a.com", "a3@a.com"]
        Any["b1@b.com", "b2@b.com"]
------------------------------------------------------
=#


