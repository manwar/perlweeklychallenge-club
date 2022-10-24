#!/usr/bin/env julia

function total_zero( bigger::Int64, smaller::Int64 ) ::Int64
    if (bigger < smaller)
        println("Please enter the pair in descending order")
        return 0
    end
    if (smaller <= 0)
        println("Please input only positive integers")
        return 0
    end
    if (bigger == smaller)
        return 1
    end
    if (bigger % smaller == 0)
        return bigger ÷ smaller
    end
    times = bigger ÷ smaller
    return times + total_zero(smaller, bigger-times*smaller)
end

println(total_zero(5,4)) #5
println(total_zero(6,4)) #3
println(total_zero(5,2)) #4
println(total_zero(3,1)) #3
println(total_zero(7,4)) #5

