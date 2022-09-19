fun is_prime(n: Int): Boolean {
    n == 2 && return true
    if (n < 2 || n % 2 == 0) {
        return false
    }
    var p = 3
    val sqrt_n : Int = Math.sqrt(n.toDouble()).toInt()
    while (p <= sqrt_n) {
        n % p == 0 && return false
        p += 2
    }
    return true
}

fun is_cyclops(num: Int): Boolean {
    val s = num.toString()
    val len = s.length
    len % 2 == 0 && return false
    val mid = ((len - 1) /2).toInt()
    s[mid] == '0' || return false
    if ('0' in s.slice(0 until mid) or '0' in s.slice(mid+1 until len) {
        return false
    }
    return true
}

fun main() {
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
        if (i.toString() != i.toString().reversed()) {
            continue;
        }
        if (! is_cyclops(i)) {
            continue;
        }
        if (is_prime(i)) {
            print("$i ")
            count++
        }
    }
    println(" ")
}
