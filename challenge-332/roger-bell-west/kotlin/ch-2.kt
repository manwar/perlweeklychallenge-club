fun counterify(a: List<Char>): Map<Char, Int> {
    var cc = mutableMapOf<Char, Int>().withDefault({0})
    for (x in a) {
        cc.set(x, cc.getValue(x) + 1)
    }
    return cc
}

fun oddletters(a: String): Boolean {
    val c = counterify(a.toCharArray().toList());
    return c.values.all{v -> v % 2 == 1}
}

fun main() {

    if (!oddletters("weekly")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (oddletters("perl")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (!oddletters("challenge")) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
