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

fun primepartition(n: Int, divs: Int): ArrayList<Int> {
    val pl = genprimes(n)
    var p = ArrayList<ArrayList<Int>>()
    p.add(ArrayList<Int>())
    while (p.size > 0) {
        val pa = p.removeLast()
        if (pa.size == divs) {
            if (pa.sum() == n) {
                return pa
            }
        } else {
            val px = pa.toSet()
            for (pq in pl) {
                if (!px.contains(pq)) {
                    var pb = ArrayList(pa)
                    pb.add(pq)
                    p.add(pb)
                }
            }
        }
    }
    return arrayListOf(n)
}

fun main() {
    if (primepartition(18, 2) == listOf(13, 5)) {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")
    
    if (primepartition(19, 3) == listOf(11, 5, 3)) {
        print("Pass")
    } else {
        print("FAIL")
    }
    println("")
}
