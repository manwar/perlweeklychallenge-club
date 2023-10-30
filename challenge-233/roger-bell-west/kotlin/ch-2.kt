fun frequencysort(a: List<Int>): List<Int> {
    var ct = mutableMapOf<Int, Int>().withDefault({0})
    for (x in a) {
        ct.set(x, ct.getValue(x) + 1)
    }
    var rct = mutableMapOf<Int, ArrayList<Int>>().withDefault({ArrayList<Int>()})
    ct.forEach { (k, v) -> run {
                    var pp = rct.getValue(v)
                    pp.add(k)
                    rct.set(v, pp)
    }}
    var out = ArrayList<Int>()
    for (k in rct.keys.sorted()) {
        val pp = rct.getValue(k)
        for (v in pp.sorted().reversed()) {
            for (i in 1..k) {
                out.add(v)
            }
        }
    }
    return out.toList()
}

fun main() {

    if (frequencysort(listOf(1, 1, 2, 2, 2, 3)) == listOf(3, 1, 1, 2, 2, 2)) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (frequencysort(listOf(2, 3, 1, 3, 2)) == listOf(1, 3, 3, 2, 2)) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (frequencysort(listOf(-1, 1, -6, 4, 5, -6, 1, 4, 1)) == listOf(5, -1, 4, 4, -6, -6, 1, 1, 1)) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
