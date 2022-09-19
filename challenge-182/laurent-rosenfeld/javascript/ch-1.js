let tests = [ [5, 2, 9, 1, 7, 6], [4, 2, 3, 1, 5, 0] ]
for  (let j = 0; j < tests.length; j++) {
    let test = tests[j]
    let max_i = 0
    let max_n = test[0]
    for (let i = 1; i <= test.length; i++) {
        if (test[i] > max_n) {
            max_n = test[i]
            max_i = i
        }
    }
    console.log("Max index for " + test + ": " + max_i + " => " + max_n)
}
