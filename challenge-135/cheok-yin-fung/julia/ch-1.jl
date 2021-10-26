# The Weekly Challenge 135
# Task 1 Middle 3-digits
# Usage: include("ch-1.jl")

function mid_three(x)
    num = 0
    if typeof(x) == Int64
        num = x
    else
        try (
            num = parse(Int64, x)
        ) catch
            return "Not an integer. / Format ill-suited."
        end
    end
    num = num > 0 ? num : -num;
    str = string(num)
    len = length(str)
    if len % 2 == 0
        return "even number of digits"
    else
        if len < 3
            return "too short"
        end
    end
    m = convert(Int64,(len+1) // 2)
    return str[m-1]*str[m]*str[m+1]
end


testcases = [1234567, -123, 1, 10, 14285, 33554432, 10737418240]

for a in testcases
    println(mid_three(a))
end


#=
345
123
too short
even number of digits
428
even number of digits
741
=#
