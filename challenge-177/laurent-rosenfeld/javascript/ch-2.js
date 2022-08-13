function is_cyclops (n) {
    let s = n.toString()
    let len = s.length
    if (len % 2 == 0) {
        return false
    }

    let mid = (len - 1) / 2
    if (s[mid] != '0') {
        return false
    }

    if (s.slice(0, mid-1).search('0') >= 0) {
        return false
    }
    if (s.slice(mid+1).search('0') >= 0) {
        return false
    }
    return true
}

function is_prime(n) {
    if (n == 2) {
        return true
    }
    if (n < 2 || n % 2 == 0) {
        return false
    }
    var p = 3
    let sqrt_n = Math.sqrt(n)
    while (p <= sqrt_n) {
        if (n % p == 0) {
            return false
        }
        p += 2
    }
    return true
}

var count = 0
var i = 100
while (count < 20) {
    i++
    if (i == 999) {
        i = 10000
    } else if (i == 99999) {
        i = 1000000
    } else if (i >= 9999999) {
        break
    }
    if (i.toString() != i.toString().split("").reverse().join("")) {
        continue;
    }
    if (! is_cyclops(i)) {
        continue;
    }
    if (is_prime(i)) {
        process.stdout.write(i + " ")
        count++
    }
}
console.log("")
