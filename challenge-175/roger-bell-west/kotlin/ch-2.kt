fun gcd(m0: Int,n0: Int): Int {
    var m=m0
    var n=n0
    while (n != 0) {
        val tmp=m % n
        m = n
        n = tmp
    }
    return m
}

fun eulertotient(n: Int): Int {
    var et = 0
    for (k in 1..n) {
        if (gcd(n,k) == 1) {
            et++
        }
    }
    return et
}

fun iteratedtotient(n0: Int): Int {
    var p = 0
    var n = n0
    while (true) {
        n = eulertotient(n)
        p += n
        if (n == 1) {
            break
        }
        if (p > n0) {
            break
        }
    }
    return p
}

fun perfecttotient(ct: Int): List<Int> {
    var o = ArrayList<Int>()
    var n = 1
    while (o.size < ct) {
        n++
        if (iteratedtotient(n) == n) {
            o.add(n)
        }
    }
    return o
}

fun main() {
    if (perfecttotient(20) == listOf( 3, 9, 15, 27, 39, 81, 111, 183,
                                      243, 255, 327, 363, 471, 729,
                                      2187, 2199, 3063, 4359, 4375, 5571 )) {
        print("Pass")
    } else {
        print("FAIL")
    }
    println("")
}
