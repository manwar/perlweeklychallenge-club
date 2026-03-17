fun alphabetindexdigitsum(a: String, k: Int): Int  {
    var st = ""
    for (c in a) {
        st += (c.code - 96).toString()
    }
    var v = st.toInt()
    for (_dummy in 1..k) {
        var j = 0
        while (v > 0) {
            j += v % 10
            v /= 10
        }
        v = j
    }
    return v
}

fun main() {

    if (alphabetindexdigitsum("abc", 1) == 6) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (alphabetindexdigitsum("az", 2) == 9) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (alphabetindexdigitsum("cat", 1) == 6) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (alphabetindexdigitsum("dog", 2) == 8) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (alphabetindexdigitsum("perl", 3) == 6) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
