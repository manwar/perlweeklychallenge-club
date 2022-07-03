function is_abundant(n) {
    let sum = 0;
    for (let i = 1; i < (n/2 + 1); i++) {
        if (n % i == 0) {
            sum += i;
            if (sum > n) {
                return true;
            }
        }
    }
    return false;
}
let count = 0
let j = 1
while (count < 20) {
    if (is_abundant(j)) {
        process.stdout.write(j + " ")
        count++
    }
    j += 2
}
