fun wordbreak(a: String, words: List<String>): Boolean {
    var queue = ArrayDeque<String>()
    queue.add(a)
    while (queue.size > 0) {
        val remnant = queue.removeFirst()
        if (remnant.length == 0) {
            return true
        } else {
            for (candidate in words) {
                if (remnant.startsWith(candidate)) {
                    queue += remnant.drop(candidate.length)
                }
            }
        }
    }
    return false
}

fun main() {

    if (wordbreak("weeklychallenge", listOf("challenge", "weekly"))) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (wordbreak("perlrakuperl", listOf("raku", "perl"))) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (!wordbreak("sonsanddaughters", listOf("sons", "sand", "daughters"))) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
