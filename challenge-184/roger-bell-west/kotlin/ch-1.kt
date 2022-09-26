fun sequencenumber(lst: List<String>): List<String> {
    var nn = 0
    var o = ArrayList<String>()
    for (ins in lst) {
        o.add(String.format("%02d", nn) + ins.subSequence(2,6))
        nn += 1
    }
    return o.toList()
}

fun main() {
    if (sequencenumber(listOf("ab1234", "cd5678", "ef1342")) ==
            listOf("001234", "015678", "021342")) {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")
    if (sequencenumber(listOf("pq1122", "rs3334")) ==
            listOf("001122", "013334")) {
        print("Pass")
    } else {
        print("FAIL")
    }
    println("")
}
