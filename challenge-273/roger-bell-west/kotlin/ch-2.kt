fun baftera(a: String): Boolean {
    val firstb = a.indexOf('b')
    val lasta = a.lastIndexOf('a')
    if (firstb == -1) {
        return false
    }
    if (lasta == -1) {
        return true
    }
    return lasta < firstb
}

fun main() {

    if (baftera("aabb")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (!baftera("abab")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (!baftera("aaa")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (baftera("bbb")) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
