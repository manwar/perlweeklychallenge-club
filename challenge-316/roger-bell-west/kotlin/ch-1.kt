fun circular(a: List<String>): Boolean {
    for (p in a.windowed(size = 2)) {
        if (p[0].last() != p[1].first()) {
            return false
        }
    }
    return true
}

fun main() {

    if (circular(listOf("perl", "loves", "scala"))) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (!circular(listOf("love", "the", "programming"))) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (circular(listOf("java", "awk", "kotlin", "node.js"))) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
