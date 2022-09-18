for test in [[5, 2, 9, 1, 7, 6], [4, 2, 3, 1, 5, 0]]
    max_i = 1
    max_n = test[1]
    for i in 2:length(test)
        if (test[i] > max_n)
            max_n = test[i]
            max_i = i
        end
    end
    println("Max index for $test: $(max_i - 1) => $max_n)")
end
