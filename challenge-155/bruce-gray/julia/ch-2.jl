function nth_Pisano_period( N )
    n = 0
    fib1 = 0
    fib2 = 1 % N
    fib2_original = fib2
    while true
        (fib1, fib2) = (fib2, (fib1 + fib2) % N)
        n += 1
        
        if fib1 == 0 && fib2 == fib2_original
            return n 
        end
    end
end

@assert [nth_Pisano_period(i) for i=1:20] == [1,3,8,6,20,24,16,12,24,60,10,24,28,48,40,24,36,24,18,60]

println(nth_Pisano_period(3))

# Recreate https://oeis.org/A001175/b001175.txt :
# for i in 1:10000
#     println(i, ' ', nth_Pisano_period(i))
# end
# for i in 1:7
#     println()
# end
