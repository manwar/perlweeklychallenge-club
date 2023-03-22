fun specialbitcharacters(a: List<Int>): Boolean {
    var s = 0
    for (v in a) {
        if (s == 1) {
            s = 2
        } else {
            s = v
        }
    }
    return s == 0
}

fun main() {

    if (specialbitcharacters(listOf(1, 0, 0))) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (!specialbitcharacters(listOf(1, 1, 1, 0))) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
