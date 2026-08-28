fun secretsanta(n: Int): Int {
    return when (n) {
        0 -> 1
        1 -> 0
        else -> (n - 1) * (secretsanta(n - 1) + secretsanta(n - 2));
    }
}

fun main() {

    if (secretsanta(1) == 0) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (secretsanta(2) == 1) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (secretsanta(3) == 2) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (secretsanta(4) == 9) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (secretsanta(5) == 44) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
