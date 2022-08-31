tests = {{{3}, {1,4,2,3,5}}, {{4}, {9,0,6,2,3,8,5}}}
for _, test in ipairs(tests) do
    local i = test[1][1]
    local nums = test[2]
    io.write("i= ", i, "; nums= ", table.concat(nums, " "), " => ")
    for _, j in ipairs(nums) do
        if j > i then
            io.write(j, " ")
        end
    end
    print("")
end
