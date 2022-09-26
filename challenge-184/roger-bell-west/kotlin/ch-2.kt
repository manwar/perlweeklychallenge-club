fun splitarray(lst: List<String>): Pair<List<List<Int>>,List<List<Char>>> {
    var outa = ArrayList<List<Int>>()
    var outb = ArrayList<List<Char>>()
    for (ins in lst) {
        var av = ArrayList<Int>()
        var bv = ArrayList<Char>()
        for (c in ins) {
            if (c >= '0' && c <= '9') {
                av.add(c.digitToInt())
            } else if (c >= 'a' && c <= 'z') {
                bv.add(c)
            }
        }
        if (av.size > 0) {
            outa.add(av.toList())
        }
        if (bv.size > 0) {
            outb.add(bv.toList())
        }
    }
    return Pair(outa.toList(), outb.toList())
}

fun main() {
    if (splitarray(listOf("a 1 2 b 0", "3 c 4 d")) ==
            Pair( listOf(listOf(1, 2, 0), listOf(3, 4)),
                  listOf(listOf('a', 'b'), listOf('c', 'd')) )) {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")
    if (splitarray(listOf("1 2", "p q r", "s 3", "4 5 t")) ==
            Pair( listOf(listOf(1, 2), listOf(3), listOf(4, 5)),
                  listOf(listOf('p', 'q', 'r'), listOf('s'), listOf('t')) )) {
        print("Pass")
    } else {
        print("FAIL")
    }
    println("")
}
