fun counterify(a: List<Char>): Map<Char, Int> {
    var cc = mutableMapOf<Char, Int>().withDefault({0})
    for (x in a) {
        cc.set(x, cc.getValue(x) + 1)
    }
    return cc
}

fun meetingpoint(a: String): Boolean {
    val c = counterify(a.toList())
    return c.getValue('U') == c.getValue('D') &&
        c.getValue('L') == c.getValue('R')
}

fun main() {

    if (!meetingpoint("ULD")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (meetingpoint("ULDR")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (!meetingpoint("UUURRRDDD")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (meetingpoint("UURRRDDLLL")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (!meetingpoint("RRUULLDDRRUU")) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
