fun keyboardword(wl: List<String>): List<String> {
    val re = "^([qwertyuiop]+|[asdfghjkl]+|[zxcvbnm]+)$".toRegex(RegexOption.IGNORE_CASE)
    var out = ArrayList<String>()
    for (w in wl) {
        if (re.containsMatchIn(w)) {
            out.add(w)
        }
    }
    return out.toList()
}

fun main() {

    if (keyboardword(listOf("Hello", "Alaska", "Dad", "Peace")) == listOf("Alaska", "Dad")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (keyboardword(listOf("OMG", "Bye")) == emptyList<String>()) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
