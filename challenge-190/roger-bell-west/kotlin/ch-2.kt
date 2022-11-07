fun decodedlist(s: String): List<String> {
    var stack = arrayListOf(arrayListOf(s))
    var out = ArrayList<ArrayList<String>>()
    while (true) {
        var ent = stack.first()
        stack = ArrayList(stack.drop(1))
        var tail = ent.last()
        ent = ArrayList(ent.dropLast(1))
        if (tail.length == 0) {
            out.add(ent)
        } else {
            if (tail.substring(0, 1) != "0") {
                var q = ArrayList(ent)
                q.add(tail.substring(0, 1))
                q.add(tail.substring(1))
                stack.add(q)
            }
            if (tail.length >= 2) {
                val v = tail.substring(0,2).toInt()
                if (v >= 1 && v <= 26) {
                    var q = ArrayList(ent)
                    q.add(tail.substring(0, 2))
                    q.add(tail.substring(2))
                    stack.add(q)
                }
            }
        }
        if (stack.size == 0) {
            break
        }
    }
    var k = ArrayList<String>()
    val alphazero = 'A'.code - 1
    for (x in out) {
        var ss = ""
        for (sc in x) {
            ss += (sc.toInt() + alphazero).toChar()
        }
        k.add(ss)
    }
    k.sort()
    return k
}

fun main() {
    if (decodedlist("11") == listOf("AA", "K")) {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")
    if (decodedlist("1115") == listOf("AAAE", "AAO", "AKE", "KAE", "KO")) {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")
    if (decodedlist("127") == listOf("ABG", "LG")) {
        print("Pass")
    } else {
        print("FAIL")
    }
    println("")
}
