fun lastword(a: String): Int {
    val w = a.split(" ").filter {it.length > 0}
    return w[w.size - 1].length
}

fun main() {

    if (lastword("The Weekly Challenge") == 9) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (lastword("   Hello   World    ") == 5) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (lastword("Let's begin the fun") == 3) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
