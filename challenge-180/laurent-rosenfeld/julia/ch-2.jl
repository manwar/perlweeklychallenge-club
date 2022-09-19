for test in [[3, [1,4,2,3,5]], [4, [9,0,6,2,3,8,5]]]
    i = test[1]
    nums = test[2]
    println( "i = $i, num = $nums => ", filter((x) -> x > i, nums))
end
