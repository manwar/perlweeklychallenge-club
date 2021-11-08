#! /usr/bin/ruby

def is_lychrel(m)
    n = m
    for k in 1..500
        j = n.to_s.reverse.to_i
        if j == n then
            return 0
        end
        n += j
        if n > 10000000 then
            return "#{m} is  a Lychrel candidate (reached the 1e7 limit)"
        end
    end
    return "#{m} is a lychrel candidate (made 500 iterations)"
end

for test in [10, 20, 30, 50, 100, 196]
    print  "#{test} -> ", is_lychrel(test), "\n"
end
