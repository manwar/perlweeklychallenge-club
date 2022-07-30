var cache = new Array(10000)
cache[0] = 0

function gcd (i, j) {
    while(j != 0) {
        k = j
        j = i % j
        i = k
    }
    return i
}

function is_perfect_totient (n) {
    let tot = 0
    for (var i = 1; i < n; i++) {
          if (gcd(n, i) == 1) {
            tot++
        }
    }
    sum = tot + cache[tot]
    cache[n] = sum
    return n == sum
}

let count = 0
let i = 1
while (count < 20) {
    if (is_perfect_totient(i)) {
        process.stdout.write(i + " ")

        count++
    }
    i++
}
process.stdout.write("\n")
