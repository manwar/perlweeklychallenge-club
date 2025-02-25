using JuMP
using GLPK
using Lazy
using Test

function ones_and_zeroes(str, max_zeroes, max_ones)
    elems = length(str)
    freq = frequencies.(str)
    ones = get.(freq, '1', 0)
    zeroes = get.(freq, '0', 0)
    
    model = Model(GLPK.Optimizer)
    @variable(model, x[1:elems], Bin)
    @objective(model, Max, sum(x) )
    @constraint(model, ones' * x ≤ max_ones)
    @constraint(model, zeroes' * x ≤ max_zeroes)
    optimize!(model)
    #println(value.(x))
    objective_value(model)
end

@testset "ones and zeroes" begin
  @test ones_and_zeroes(["10", "00001", "11101", "1", "0"],5,3) == 3
  @test ones_and_zeroes(["10", "0001", "111001", "1", "0"],2,2) == 3
  @test ones_and_zeroes(["10", "0001", "111001", "1", "0"],7,7) == 5
  @test ones_and_zeroes(["10", "0001", "111001", "1", "0"],5,3) == 4
  @test ones_and_zeroes(["10", "1", "0"],1,1) == 2
end
