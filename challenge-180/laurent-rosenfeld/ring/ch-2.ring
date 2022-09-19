for test in [[3, [1,4,2,3,5]], [4, [9,0,6,2,3,8,5]]]
    i = test[1]
    nums = test[2]
    see "i = " + i + " ; nums = "
    for j in nums
        see "" + j + " "
    next
    see " => "
    for j in nums
        if j > i
            see "" + j + " "
        ok
    next
    see " " +nl
next
