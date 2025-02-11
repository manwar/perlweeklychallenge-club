fun countcommon(a: List<String>, b: List<String>): Int {
    val aa = a.toSet()
    val bb = b.toSet()
    return aa.intersect(bb).toList().count()
}

fun main() {

    if (countcommon(listOf("perl", "weekly", "challenge"), listOf("raku", "weekly", "challenge")) == 2) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (countcommon(listOf("perl", "raku", "python"), listOf("python", "java")) == 1) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (countcommon(listOf("guest", "contribution"), listOf("fun", "weekly", "challenge")) == 0) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
