fun secondlargestdigit(a: String): Int {
    var k = ArrayList(a.toList().filter {it >= '0' && it <= '9'}.toSet())
    k.sort()
    k.reverse()
    if (k.size > 1) {
        return k[1].digitToInt()
    } else {
        return -1
    }
}

fun main() {

    if (secondlargestdigit("aaaaa77777") == -1) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (secondlargestdigit("abcde") == -1) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (secondlargestdigit("9zero8eight7seven9") == 8) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (secondlargestdigit("xyz9876543210") == 8) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (secondlargestdigit("4abc4def2ghi8jkl2") == 4) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
