val cache = Array(10000, {i-> 0})

fun gcd (m: Int, n: Int): Int {
    var i = m
    var j = n
    while(j != 0) {
        val k = j
        j = i % j
        i = k
    }
    return i
}

fun is_perfect_totient(n: Int): Boolean {
    var tot = 0
    for (i in 1..n-1) {
        if (gcd(n, i) == 1) {
            tot++
        }
    }
    val sum = tot + cache[tot]
    cache[n] = sum
    return n == sum
}

fun main() {
    var i = 0
    var count = 0
    while (count <= 20) {
        if (is_perfect_totient(i)) {
            print("$i ")
            count++
        }
        i++
    }
    println(" ")
}
