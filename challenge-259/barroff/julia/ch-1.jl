#!/usr/bin/env julia

using Dates

using Test: @test, @testset

function banking_day_offset(
    start_date::Date,
    offset::T,
    bank_holidays::Vector{Date} = Date[],
)::Date where {T<:Integer}
    if (start_date in bank_holidays) || (Dates.dayofweek(start_date) in (6, 7))
        return banking_day_offset(start_date + Day(1), offset, bank_holidays)
    end
    if offset == 0
        return start_date
    end
    return banking_day_offset(start_date + Day(1), offset - 1, bank_holidays)
end

@testset "Banking day offset" begin
    @test banking_day_offset(
        Date("2018-06-28", dateformat"y-m-d"),
        3,
        [Date("2018-07-03", dateformat"y-m-d")],
    ) == Date("2018-07-04", dateformat"y-m-d")
    @test banking_day_offset(Date("2018-06-28", dateformat"y-m-d"), 3) ==
          Date("2018-07-03", dateformat"y-m-d")
end
