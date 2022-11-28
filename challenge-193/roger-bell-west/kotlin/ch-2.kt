import kotlin.math.*

fun oddstring(ss: List<String>): String {
    for (i in 0..ss[0].length-2) {
        var tab = mutableMapOf<Int, ArrayList<String>>()
        for (s in ss) {
            val v = s[i+1].code - s[i].code
            var ll = tab.getOrDefault(v, ArrayList<String>())
            ll.add(s)
            tab.put(v, ll)
        }
        for (j in tab.values) {
            if (j.size == 1) {
                return j[0]
            }
        }
    }
    return ""
}

fun main() {
    if (oddstring(listOf("adc", "wzy", "abc")) == "abc") {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")   
    if (oddstring(listOf("aaa", "bob", "ccc", "ddd")) == "bob") {
        print("Pass")
    } else {
        print("FAIL")
    }
    println("")
}
