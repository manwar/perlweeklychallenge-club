fun validator(a0: List<Int>): Int {
    val a = a0.sorted()
    val l = a.size
    if (a[0] == 0 && a[l - 2] == 0 && a[l - 1] == 1) {
        return a0.indexOf(1)
    } else {
        return -1
    }
}

fun specialpositions(a: List<List<Int>>): Int {
    var vr = mutableSetOf<Pair<Int, Int>>()
    var xs = mutableSetOf<Int>()
    a.forEachIndexed{y, row ->
                         val x = validator(row)
                     if (x > -1) {
                         vr.add(Pair(y, x))
                         xs.add(x)
                     }
    }
    var xd = mutableSetOf<Int>()
    for (x in xs) {
        val c = a.map{ it[x] }.toList()
        if (validator(c) == -1) {
            xd.add(x)
        }
    }
    xs.removeAll(xd)
    return vr.filter{xs.contains(it.second)}.size
}

fun main() {

    if (specialpositions(listOf(listOf(1, 0, 0), listOf(0, 0, 1), listOf(1, 0, 0))) == 1) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (specialpositions(listOf(listOf(1, 0, 0), listOf(0, 1, 0), listOf(0, 0, 1))) == 3) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
