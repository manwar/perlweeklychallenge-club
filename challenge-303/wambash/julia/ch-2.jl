using JuMP
using GLPK
using Lazy
using Test

function delete_and_earn(ints)
    freq = frequencies(ints)
    adepts = keys(freq)

    model = Model(GLPK.Optimizer)
    @variable(model, x[i in adepts], Bin)
    @objective(model, Max, sum(i * freq[i] * x[i]  for i in keys(freq)) )

    #@constraint(model, [i in adepts if i+1 in adepts], x[i]+x[i+1] ≤ 1)
    for i in adepts
        if i+1 in adepts
            @constraint(model, x[i] + x[i + 1] ≤ 1)
        end
    end
    optimize!(model)
    #@show value.(x)
    objective_value(model)
end

@testset "delete and earn" begin
   @test delete_and_earn([3,4,2]) == 6
   @test delete_and_earn([2, 2, 3, 3, 3, 4]) == 9
end
