import kotlin.math.min

fun isqrt(s: Int): Int {
    if (s <= 1) {
        return s
    } else {
        var x0 = s / 2
        var x1 = (x0 + s / x0) / 2
        while (x1 < x0) {
            x0 = x1
            x1 = (x0 + s / x0) / 2
        }
        return x0
    }
}

fun genprimes(mx: Int): ArrayList<Int> {
    var primesh=mutableSetOf<Int>()
    for (i in 2..3) {
        primesh.add(i)
    }
    for (i in 6..mx+1 step 6) {
        for (j in i-1..i+1 step 2) {
            if (j <= mx) {
                primesh.add(j)
            }
        }
    }
    var q=ArrayDeque(listOf(2,3,5,7))
    var p=q.removeAt(0)
    val mr=isqrt(mx)
    while (p <= mr) {
        if (primesh.contains(p)) {
            for (i in p*p..mx step p) {
                primesh.remove(i)
            }
        }
        if (q.size < 2) {
            q.add(q.last()+4)
            q.add(q.last()+2)
        }
        p=q.removeAt(0)
    }
    var primes=ArrayList(primesh.distinct())
    primes.sort()
    return primes
}

fun primestep(a: String): Int {
    val g = a.toList().map{it.code}.sum()
    val pm = genprimes(g * 2)
    val bs = pm.binarySearch(g)
    if (bs >= 0) {
        return 0
    } else {
        val ip = -(bs + 1)
        return min(g - pm[ip - 1], pm[ip] - g)
    }
}

fun main() {

    if (primestep("hello") == 9) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (primestep("football") == 2) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (primestep("a") == 0) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (primestep("challenge") == 2) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (primestep("perl") == 2) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
