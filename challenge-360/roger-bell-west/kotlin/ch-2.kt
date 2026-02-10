fun wordsorter(a: String): String {
    var w = ArrayList(a.split(" ").filter{it != ""})
    w.sortBy {it.lowercase()}
    return w.joinToString(" ")
}

fun main() {

    if (wordsorter("The quick brown fox") == "brown fox quick The") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (wordsorter("Hello    World!   How   are you?") == "are Hello How World! you?") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (wordsorter("Hello") == "Hello") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (wordsorter("Hello, World! How are you?") == "are Hello, How World! you?") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (wordsorter("I have 2 apples and 3 bananas!") == "2 3 and apples bananas! have I") {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
