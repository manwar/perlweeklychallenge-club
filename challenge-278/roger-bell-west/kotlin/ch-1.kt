fun sortstring(a: String): String {
    var words = a.split(" ")
    var out = ArrayList<String>(words)
    val re = "^(.*?)([0-9]+)$".toRegex()
    for (w in words) {
        val mr = re.find(w)
        var index = mr!!.groupValues[2].toInt() - 1
        out[index] = mr.groupValues[1]
    }
    return out.joinToString(" ")
}

fun main() {

    if (sortstring("and2 Raku3 cousins5 Perl1 are4") == "Perl and Raku are cousins") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (sortstring("guest6 Python1 most4 the3 popular5 is2 language7") == "Python is the most popular guest language") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (sortstring("Challenge3 The1 Weekly2") == "The Weekly Challenge") {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
