using Lazy
using Primes

special_numbers(ints) = @>> begin
    ints
    length
    divisors
    getindex(ints)
    x -> x.^2
    sum
end


using Test
@testset "special numbers" begin
    @test special_numbers([1,2,3,4]) == 21
    @test special_numbers([2, 7, 1, 19, 18, 3]) == 63
end
