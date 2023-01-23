fun arithmeticslices(l: List<Int>): List<List<Int>> {
    var o = ArrayList<List<Int>>()
    if (l.size >= 3) {
        for (a in 0..l.size-3) {
            var valid = false
            for (b in a+2..l.size-1) {
                val v = l.slice(a .. b).toList()
                if (!valid) {
                    for (i in 0..v.size-3) {
                        if (v[i+1] - v[i] == v[i+2] - v[i+1]) {
                            valid = true
                            break
                        }
                    }
                }
                if (valid) {
                    o.add(v)
                }
            }
        }
    }
    return o.toList()
}

fun main() {

    if (arithmeticslices(listOf(1, 2, 3, 4)) == listOf(listOf(1, 2, 3), listOf(1, 2, 3, 4), listOf(2, 3, 4))) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (arithmeticslices(listOf(2)) == emptyList<Int>()) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
