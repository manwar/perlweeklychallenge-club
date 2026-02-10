fun textjustifier(intxt: String, width: Int): String {
    var working = ArrayList<Char>()
    for (i in 1 .. width) {
        working.add('*')
    }
    val offset = (width - intxt.length) / 2
    intxt.toList().forEachIndexed { i, c ->
                                        working[i + offset] = c
    }
    return working.joinToString("")
}

fun main() {

    if (textjustifier("Hi", 5) == "*Hi**") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (textjustifier("Code", 10) == "***Code***") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (textjustifier("Hello", 9) == "**Hello**") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (textjustifier("Perl", 4) == "Perl") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (textjustifier("A", 7) == "***A***") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (textjustifier("", 5) == "*****") {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
