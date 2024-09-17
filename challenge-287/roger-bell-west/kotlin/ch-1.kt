fun strongpassword(a: String): Int {
    var ctypes = mutableMapOf<Char, Int>().withDefault({0})
    var reps = 0
    var rep = 0
    var old = '@'
    var changes = ArrayList<Int>()
    a.toList().forEachIndexed{i, c ->
        if (i > 0 && c == old) {
            rep += 1
            if (rep >= 2) {
                reps += 1
            }
        } else {
            rep = 0
            old = c
        }
        var t = 'n'
        if (c >= 'A' && c <= 'Z') {
            t = 'u'
        } else if (c >= 'a' && c <= 'z') {
            t = 'l'
        } else if (c >= '0' && c <= '9') {
            t = 'd'
        }
        ctypes.set(t, ctypes.getValue(t) + 1)
    }
    changes.add(reps)
    ctypes.remove('n')
    var k = ctypes.keys.size
    if (k < 3) {
        var spare = ctypes.values.reduce{x, y -> x + y} - k
        if (spare < 0) {
            changes.add(-spare)
        }
    }
    if (a.length < 6) {
        changes.add(6 - a.length)
    }
    return changes.maxOrNull()!!
}

fun main() {

    if (strongpassword("a") == 5) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (strongpassword("aB2") == 3) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (strongpassword("PaaSW0rd") == 0) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (strongpassword("Paaasw0rd") == 1) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (strongpassword("aaaaa") == 3) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
