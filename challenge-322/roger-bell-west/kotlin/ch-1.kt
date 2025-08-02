fun formatstring(a: String, n: Int): String {
    val p = a.toCharArray().filter{it != '-'}
    var r = p.size % n
    if (r == 0) {
        r += n
    }
    var o =""
    p.forEachIndexed {i, c ->
                          if (r == i) {
                              o += '-'
                              r += n
                          }
                      o += c
    }
    return o
}

fun main() {

    if (formatstring("ABC-D-E-F", 3) == "ABC-DEF") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (formatstring("A-BC-D-E", 2) == "A-BC-DE") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (formatstring("-A-B-CD-E", 4) == "A-BCDE") {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
