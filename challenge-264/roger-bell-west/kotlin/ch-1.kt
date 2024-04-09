fun greatestenglishletter(a: String): String {
    var m = mutableMapOf<Char, Int>().withDefault({0})
    for (c in a.toCharArray()) {
        val uc = c.uppercaseChar()
        val flag = if (c.isUpperCase()) { 1 } else { 2 }
        m.set(uc, m.getValue(uc) or flag)
    }
    val s = m.keys.toList().filter { m.getValue(it) == 3 }
    if (s.size == 0) {
        return ""
    }
    return s.sorted().last().toString()
}

fun main() {

    if (greatestenglishletter("PeRlwEeKLy") == "L") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (greatestenglishletter("ChaLlenge") == "L") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (greatestenglishletter("The") == "") {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
