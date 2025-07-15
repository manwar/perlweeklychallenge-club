fun titlecapital(a: String): String {
    var out = ArrayList<String>()
    for (w in a.split(" ")) {
        var p = w.lowercase()
        if (p.length > 2) {
            var c = p.toCharArray()
            c[0] = c[0].uppercaseChar()
            p = c.joinToString("")
        }
        out.add(p)
    }
    return out.joinToString(" ")
}

fun main() {

    if (titlecapital("PERL IS gREAT") == "Perl is Great") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (titlecapital("THE weekly challenge") == "The Weekly Challenge") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (titlecapital("YoU ARE A stAR") == "You Are a Star") {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
