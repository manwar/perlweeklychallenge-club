fun binarydate(a: String): String {
    return a.split("-").map{it.toInt().toString(2)}.joinToString("-")
}

fun main() {

    if (binarydate("2025-07-26") == "11111101001-111-11010") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (binarydate("2000-02-02") == "11111010000-10-10") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (binarydate("2024-12-31") == "11111101000-1100-11111") {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
