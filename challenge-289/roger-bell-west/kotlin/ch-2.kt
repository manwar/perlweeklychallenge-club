fun jumble(a: String): String {
    return a.split("").shuffled().joinToString("")
}

fun main() {
    val wordrx = """([A-Za-z])([A-Za-z][A-Za-z]+)([A-Za-z])""".toRegex()
    while(true) {
        var line = readLine()
        if (line == null) {
            break
        }
        println(
            line.replace(wordrx) { val s = it.groupValues
                                   s[1] + jumble(s[2]) + s[3] }
        )
    }
}
