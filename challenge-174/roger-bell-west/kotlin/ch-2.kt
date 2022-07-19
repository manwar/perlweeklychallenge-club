fun permutation2rank(perm: List<Int>): Int {
    var n = 0
    var pp = ArrayList(perm).sorted()
    var oi = ArrayList<Int>()
    var l = 1
    for (index in 2..perm.size) {
        oi.add(l)
        l *= index
    }
    oi.reverse()
    for (index in 0..perm.size-2) {
        var base = mutableMapOf<Int,Int>()
        for ((i,e) in pp.withIndex()) {
            base[e]=i
        }
        n += oi[index] * base[perm[index]]!!;
        base.remove(perm[index])
        pp = base.keys.sorted()
    }
    return n
}

fun rank2permutation(perm: List<Int>, rank0: Int): List<Int> {
    var rank = rank0
    var pp = ArrayList(perm).sorted()
    var o = ArrayList<Int>()
    var oi = ArrayList<Int>()
    var l = 1
    for (index in 2..perm.size) {
        oi.add(l)
        l *= index
    }
    oi.reverse()
    for (index in 0..perm.size-2) {
        val ix = rank / oi[index]
        o.add(pp[ix])
        pp = pp.filter{it != pp[ix]}
        rank %= oi[index]
    }
    o.add(pp[0])
    return o
}

fun main() {
    if (permutation2rank(listOf(1,0,2)) == 2) {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")
    if (rank2permutation(listOf(0,1,2),1) == listOf(0,2,1)) {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")
    if (permutation2rank(listOf(2,0,3,1)) == 13) {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")
    if (rank2permutation(listOf(1,3,2,0),7) == listOf(1,0,3,2)) {
        print("Pass")
    } else {
        print("FAIL")
    }
    println(" ")
}
