tests = [[[3], [1,4,2,3,5]], [[4], [9,0,6,2,3,8,5]]];
for(let j = 0; j < tests.length; j++) {
    let i = tests[j][0][0]
    let nums = tests[j][1]
    process.stdout.write("i= " + i + " nums= " + nums + "  =>  ")
    for (let k = 0; k < nums.length; k++) {
        if ( nums[k] > i) {
            process.stdout.write(nums[k] + " ")
        }
    }
    process.stdout.write("\n")
}
