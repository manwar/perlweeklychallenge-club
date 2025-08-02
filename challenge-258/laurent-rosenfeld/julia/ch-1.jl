using Printf

function count_even_digits_ints(invals)
    evens = filter(x -> (mod(length(string(x)), 2 ) == 0), invals)
    return size(evens, 1)
end

tests = [ [100, 1, 111, 424, 1000],
          [111, 1, 11111], [2, 8, 1024, 256] ]

for test in tests
    @printf "%-25s => " "$test"
    println("$(count_even_digits_ints(test))")
end
