fun replacequestionmark(a: String): List<String> {
    val template = a.toList()
    val q = template.filter{it == '?'}.size
    if (q == 0) {
        return listOf(a)
    } else {
        var out = ArrayList<String>()
        for (n in 0 .. (1 shl q)-1) {
            var qm = ArrayList<Char>()
            var nn = n
            while (nn > 0) {
                if (nn % 2 == 0) {
                    qm.add('0')
                } else {
                    qm.add('1')
                }
                nn /= 2
            }
            while (qm.size < q) {
                qm.add('0')
            }
            var entry = ""
            for (tc in template) {
                if (tc == '?') {
                    entry += qm.removeAt(qm.lastIndex)
                } else {
                    entry += tc
                }
            }
            out.add(entry)
        }
        return out.toList()
    }
}

fun main() {

    if (replacequestionmark("01??0") == listOf("01000", "01010", "01100", "01110")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (replacequestionmark("101") == listOf("101")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (replacequestionmark("???") == listOf("000", "001", "010", "011", "100", "101", "110", "111")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (replacequestionmark("1?10") == listOf("1010", "1110")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (replacequestionmark("1?1?0") == listOf("10100", "10110", "11100", "11110")) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
