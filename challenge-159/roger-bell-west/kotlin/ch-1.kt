import kotlin.math.*

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

fun lcm(m: Int,n: Int): Int {
    return m/gcd(m,n)*n
}

fun lcmseries(s: List<Int>): Int {
    return s.reduce { acc, x -> lcm(acc,x) }
}

fun farey(n: Int): List<Pair<Int,Int>> {
    val l = lcmseries((2..n).toList())
    var d = mutableMapOf<Int,Pair<Int,Int>>()
    var s = ArrayList<Int>()
    for (i in 1..n) {
        val m = l / i
        for (j in 0..i) {
            val k = m * j
            if (!d.contains(k)) {
                d[k]=Pair(j,i)
                s.add(k)
            }
        }
    }
    s.sort()
    return s.map {d[it]!!}
}

fun main() {
    if (farey(5) == listOf(
            Pair(0, 1), Pair(1, 5), Pair(1, 4), Pair(1, 3),
            Pair(2, 5), Pair(1, 2), Pair(3, 5), Pair(2, 3),
            Pair(3, 4), Pair(4, 5), Pair(1, 1)
    )) {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")
    if (farey(7) == listOf(
            Pair(0, 1), Pair(1, 7), Pair(1, 6), Pair(1, 5),
            Pair(1, 4), Pair(2, 7), Pair(1, 3), Pair(2, 5),
            Pair(3, 7), Pair(1, 2), Pair(4, 7), Pair(3, 5),
            Pair(2, 3), Pair(5, 7), Pair(3, 4), Pair(4, 5),
            Pair(5, 6), Pair(6, 7), Pair(1, 1)
    )) {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")
    if (farey(4) == listOf(
            Pair(0, 1), Pair(1, 4), Pair(1, 3), Pair(1, 2),
            Pair(2, 3), Pair(3, 4), Pair(1, 1)
    )) {
        print("Pass")
    } else {
        print("FAIL")
    }
    println("")
}
