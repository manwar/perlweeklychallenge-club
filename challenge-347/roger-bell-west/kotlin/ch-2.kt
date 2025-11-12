fun formatphonenumber(a: String): String {
    val pure = a.toList().filter{it >= '0' && it <= '9'}
    var left = pure.size
    var out = ArrayList<Char>()
    var i = 0
    if (left > 4) {
        for (c in pure) {
            out.add(c)
            i += 1
            left -= 1
            if (i % 3 == 0) {
                out.add('-')
                if (left <= 4) {
                    break
                }
            }
        }
    }
    if (left == 4) {
        out.add(pure[i])
        out.add(pure[i + 1])
        out.add('-')
        i += 2
    }
    for (p in i .. pure.size - 1) {
        out.add(pure[p])
    }
    return out.joinToString("")
}

fun main() {

    if (formatphonenumber("1-23-45-6") == "123-456") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (formatphonenumber("1234") == "12-34") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (formatphonenumber("12 345-6789") == "123-456-789") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (formatphonenumber("123 4567") == "123-45-67") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (formatphonenumber("123 456-78") == "123-456-78") {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
