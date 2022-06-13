import kotlin.math.*

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
    var p=q.removeFirst()
    val mr=sqrt(mx.toDouble()).toInt()
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
        p=q.removeFirst()
    }
    var primes=ArrayList(primesh.distinct())
    primes.sort()
    return primes
}

fun brilliant(ct: Int): List<Int> {
    var base = 1
    var out = mutableSetOf<Int>()
    while (true) {
        val pl = genprimes(base * 10).filter{it >= base}
        for (ai in 0..pl.size-1) {
            for (bi in ai..pl.size-1) {
                out.add( pl[ai] * pl[bi] )
            }
        }
        if (out.size >= ct) {
            break
        }
        base *= 10
    }
    return out.toList().sorted().subList(0,ct)
}

fun main() {
    if (brilliant(20) == listOf(4, 6, 9, 10, 14, 15, 21, 25, 35, 49,
                                121, 143, 169, 187, 209, 221, 247,
                                253, 289, 299)) {
        print("Pass")
    } else {
        print("FAIL")
    }
    println("")
}
