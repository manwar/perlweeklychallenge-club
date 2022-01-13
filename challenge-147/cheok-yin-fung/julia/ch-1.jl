# The Weekly Challenge 147
# Task 1 Truncatable Prime
# Thursday, January 13, 2022 PM03:18:00 


left_trun_primes = [2, 3, 5, 7]
primes = [2, 3, 5, 7]
index_ltp = [1, 5]



lastelement(array) = array[length(array)]
x_no_less_than_sqrt_y(x, y) = x ≤ √y


function grep(func, array)
    ans = []
    for variable in array
        if func(variable)
            push!(ans, variable)
        end
    end
    return Tuple(ans)
end


function is_prime(int)
    no_less_than_sqrt(x) = x_no_less_than_sqrt_y(x, int)
    relatively_small_primes = grep(no_less_than_sqrt , primes)
    for p in relatively_small_primes
        if int % p == 0
            return false
        end
    end
    return true
end


function append_arr_of_ltp(digits)
    k = 0
    for d = 1:9
        for ind = index_ltp[digits-1]:(index_ltp[digits]-1)
            new_num = parse(Int64, string(d) * string(left_trun_primes[ind]))
            if is_prime(new_num)
                push!(left_trun_primes, new_num)
                k += 1
            end
        end
    end
    push!(index_ltp, lastelement(index_ltp) + k + 1)
end


function append_arr_of_primes(min,max)
    for num = min:max
        if is_prime(num)
            push!(primes, num)
        end
    end
end



append_arr_of_ltp(2)
append_arr_of_primes(10,sqrt(999))
append_arr_of_ltp(3)
println(left_trun_primes[1:20])
