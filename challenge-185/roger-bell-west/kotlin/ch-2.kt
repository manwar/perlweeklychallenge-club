fun recomposemaskcode(lst: List<String>): List<String> {
    var out = ArrayList<String>()
    for (ins in lst) {
        var count = 0
        var os = ""
        for (c in ins) {
            if ((c >= '0' && c <= '9') || (c >= 'a' && c <= 'z')) {
                if (count < 4) {
                    count += 1
                    os += "x"
                } else {
                    os += c
                }
            } else {
                os += c
            }
        }
        out.add(os)
    }
    return out
}

fun main() {
    if (recomposemaskcode(listOf("ab-cde-123", "123.abc.420",
                                 "3abc-0010.xy")) ==
            listOf("xx-xxe-123", "xxx.xbc.420", "xxxx-0010.xy")) {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")
    if (recomposemaskcode(listOf("1234567.a", "a-1234-bc",
                                 "a.b.c.d.e.f")) ==
            listOf("xxxx567.a", "x-xxx4-bc", "x.x.x.x.e.f")) {
        print("Pass")
    } else {
        print("FAIL")
    }
    println("")
}
