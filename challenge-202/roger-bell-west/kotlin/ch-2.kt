fun widestvalley(a: List<Int>): List<Int> {
    var av = ArrayList<Int>()
    var ac = ArrayList<Int>()
    var l = -1
    for (v in a) {
        if (v == l) {
            ac[ac.size - 1] += 1
        } else {
            av.add(v)
            ac.add(1)
            l = v
        }
    }
    var s = ArrayList<Int>()
    var e = ArrayList<Int>()
    var c = 0
    for (i in 0 .. av.size-1) {
        if (i == 0 || i == av.size - 1 || (av[i - 1] < av[i] && av[i] > av[i + 1])) {
            s.add(c)
            e.add(c + ac[i] - 1)
        }
        c += ac[i]
    }
    var out = emptyList<Int>()
    for (i in 0 .. s.size - 2) {
        if (e[i + 1] - s[i] + 1 > out.size) {
            out = a.slice(s[i] .. e[i + 1]).toList()
        }
    }
    return out
}

fun main() {

    if (widestvalley(listOf(1, 5, 5, 2, 8)) == listOf(5, 5, 2, 8)) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (widestvalley(listOf(2, 6, 8, 5)) == listOf(2, 6, 8)) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (widestvalley(listOf(9, 8, 13, 13, 2, 2, 15, 17)) == listOf(13, 13, 2, 2, 15, 17)) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (widestvalley(listOf(2, 1, 2, 1, 3)) == listOf(2, 1, 2)) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (widestvalley(listOf(1, 3, 3, 2, 1, 2, 3, 3, 2)) == listOf(3, 3, 2, 1, 2, 3, 3)) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
