fun brokenkeyboard(a: String, b: List<String>): Int {
    val bk = b.map{ it.lowercase().toList()[0] }.toSet()
    var ct = 0
    for (w in a.split(" ")) {
        val nl = w.lowercase().toSet()
        if (bk.intersect(nl).isEmpty()) {
            ct += 1
        }
    }
    return ct
}

fun main() {

    if (brokenkeyboard("Hello World", listOf("d")) == 1) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (brokenkeyboard("apple banana cherry", listOf("a", "e")) == 0) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (brokenkeyboard("Coding is fun", emptyList<String>()) == 3) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (brokenkeyboard("The Weekly Challenge", listOf("a", "b")) == 2) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (brokenkeyboard("Perl and Python", listOf("p")) == 1) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
