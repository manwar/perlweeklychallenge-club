function is_lychrel(n)
    m = n
    for k = 1:500
        if (n > 10_000_000)
            return "$m is a Lychrel candidate. Reached the 1e7 limit"
        end
        rev = parse(Int64, reverse(string(n)))
        if (n == rev) return 0 end
        n += rev
    end
    return "$m is a lychrel candidate (made 500 iterations)";
end

for test in [10, 20, 30, 50, 100, 196]
    println("$test ->  $(is_lychrel(test))")
end
