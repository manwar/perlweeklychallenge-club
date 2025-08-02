using Base: bitcount
#!/usr/bin/env julia

using Test: @test, @testset

function sort_by_1_bits(ints::Vector{T})::Vector{T} where {T<:Integer}
    bc = Dict{T,Int}(
        x => sum(
            y -> parse(Int, y),
            split(
                string(x, base=2),
                ""
            )
        ) for x in ints
    )
    sort(
        collect(keys(bc)),
        lt=(x, y) -> bc[x] == bc[y] ? x < y : bc[x] < bc[y]
    )
end

@testset "sort by 1 bits" begin
    @test sort_by_1_bits(collect(0:8)) == [0, 1, 2, 4, 8, 3, 5, 6, 7]
    @test sort_by_1_bits([2^x for x in 10:-1:6]) == [2^x for x in 6:10]
end
