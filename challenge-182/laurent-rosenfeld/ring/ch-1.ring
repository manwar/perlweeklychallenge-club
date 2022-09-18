for test in [[5, 2, 9, 1, 7, 6], [4, 2, 3, 1, 5, 0]]
    max_i = 1
    max_n = test[1]
    str = ""
    for i = 1 to len(test)
        str = str + test[i] + " "
        if test[i] > max_n
            max_n = test[i]
            max_i = i
        ok
    next
    see "Max index for " + str + ": " +
        (max_i - 1) + " => " + max_n + nl
next
