fun productsign(a: List<Int>): Int {
    var out = 1
    for (t in a) {
        if (t < 0) {
            out = -out
        } else if (t == 0) {
            out = 0
        }
    }
    return out
}

fun main() {

    if (productsign(listOf(-1, -2, -3, -4, 3, 2, 1)) == 1) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (productsign(listOf(1, 2, 0, -2, -1)) == 0) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (productsign(listOf(-1, -1, 1, -1, 2)) == -1) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
