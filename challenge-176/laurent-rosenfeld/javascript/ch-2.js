function is_reversible (n) {
    var digits = n.toString().split("")
    let reverse_digits = digits.reverse()
    let reverse_n = parseInt(reverse_digits.join(""));
    var sum = n + reverse_n
    while (sum > 0) {
        let k = sum % 10
        if (k % 2 == 0) {
          return false
        }
        sum = Math.floor(sum / 10)
    }
    return true
}

for (var i = 1; i <= 100; i++) {
    if (is_reversible(i)) {
        process.stdout.write(i + " ")
    }
}
process.stdout.write(" \n")
