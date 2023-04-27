fun rankscore(a: List<Int>): List<String> {
    var av = mutableMapOf<Int, Int>()
    for (s in a) {
        if (av.contains(s)) {
            av.put(s, av.get(s)!! + 1)
        } else {
            av.put(s, 1)
        }
    }
    var kk = ArrayList(av.keys)
    kk.sortWith(compareByDescending { it })
    var rank = 1
    var tab = mutableMapOf<Int, String>()
    for (k in kk) {
        val siz = av.get(k)!!
        var r: String
        if (rank <= 3) {
            r = listOf("G", "S", "B")[rank - 1]
        } else {
            r = rank.toString()
        }
        if (siz > 1) {
            r += "="
        }
        tab.put(k, r)
        rank += siz
    }
    return a.map {tab.get(it)!!}.toList()
}

fun main() {

    if (rankscore(listOf(1, 2, 4, 3, 5)) == listOf("5", "4", "S", "B", "G")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (rankscore(listOf(8, 5, 6, 7, 4)) == listOf("G", "4", "B", "S", "5")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (rankscore(listOf(3, 5, 4, 2)) == listOf("B", "G", "S", "4")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (rankscore(listOf(2, 5, 2, 1, 7, 5, 1)) == listOf("4=", "S=", "4=", "6=", "G", "S=", "6=")) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
