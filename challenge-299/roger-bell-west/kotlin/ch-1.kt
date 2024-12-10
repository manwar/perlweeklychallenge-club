fun replacewords(ww: List<String>, a: String): String {
    var out = ArrayList<String>()
    for (w in a.split(" ")) {
        var r = false
        for (lw in ww) {
            if (w.startsWith(lw)) {
                out.add(lw)
                r = true
                break
            }
        }
        if (!r) {
            out.add(w)
        }
    }
    return out.joinToString(" ")
}

fun main() {

    if (replacewords(listOf("cat", "bat", "rat"), "the cattle was rattle by the battery") == "the cat was rat by the bat") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (replacewords(listOf("a", "b", "c"), "aab aac and cac bab") == "a a a c b") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (replacewords(listOf("man", "bike"), "the manager was hit by a biker") == "the man was hit by a bike") {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
