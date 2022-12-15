fun specialintegers(n: Int): Int {
    var o = 0
    for (i in 1..n) {
        var f = mutableMapOf<Char, Int>()
        for (c in i.toString()) {
            var l = f.getOrDefault(c, 0)
            f.set(c, l + 1)
        }
        if (f.values.maxOrNull()!! == 1) {
            o += 1
        }
    }
    return o
}

fun main() {
    if (specialintegers(15) == 14) {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")

    if (specialintegers(35) == 32) {
        print("Pass")
    } else {
        print("FAIL")
    }
    println("")
}
