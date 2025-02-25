check_order(ints) =  keys(ints)[ints.!==sort(ints)]


using Test

function TEST()
    @testset "Check Order" begin
        @test check_order([5, 2, 4, 3, 1]) == [1,3,4,5]
        @test check_order([1, 2, 1, 1, 3]) == [2,4]
        @test check_order([3, 1, 3, 2, 3]) == [1,2,4]
    end
end

TEST()
