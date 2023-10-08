#!/usr/bin/env julia
using Lazy
using Dates

seizetheday(year, month, week_day_of_month, day_of_week) = @as x begin
    Date(year, month, 1)
    range(x, x+Month(1))
    filter( day -> dayofweek(day) == day_of_week, x)
    get(x,week_day_of_month, missing)
    day
end


using Test
seizetheday() = @testset "seizetheday" begin
    @test seizetheday(2024, 4,3,2) == 16
    @test seizetheday(2025,10,2,4) == 9
    @test seizetheday(2026, 8,5,3) |> ismissing
end

println(seizetheday(map(x -> parse(Int,x),ARGS)...))
