import kotlin.math.*

fun fim(n0: Int): String {
    val words=listOf("zero","one","two","three","four",
                     "five","six","seven","eight","nine")
    var n=n0
    var p=ArrayList<String>()
    while (true) {
        var s = words[n] + " is "
        if (n == 4) {
            s += "magic."
            p.add(s)
            break
        } else {
            n = words[n].length
            s += words[n]
            p.add(s)
        }
    }
    return p.joinToString(", ").replaceFirstChar(Char::titlecase)
}

fun main() {
    if (fim(5) == "Five is four, four is magic.") {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")
    if (fim(7) == "Seven is five, five is four, four is magic.") {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")
    if (fim(6) == "Six is three, three is five, five is four, four is magic.") {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")
    if (fim(4) == "Four is magic.") {
        print("Pass")
    } else {
        print("FAIL")
    }
    println("")
}
