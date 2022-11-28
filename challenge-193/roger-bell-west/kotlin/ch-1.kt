fun binarystring(n: Int): List<String> {
    var o = ArrayList<String>()
    for (a in 0..(1 shl n)-1) {
        o.add(Integer.toBinaryString(a).padStart(n, '0'))
    }
    return o.toList()
}

fun main() {
    if (binarystring(2) == listOf("00", "01", "10", "11")) {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")
    if (binarystring(3) == listOf("000", "001", "010", "011", "100", "101", "110", "111")) {
        print("Pass")
    } else {
        print("FAIL")
    }
    println("")
}
