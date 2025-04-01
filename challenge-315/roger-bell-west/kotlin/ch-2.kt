fun findthird(s: String, a: String, b: String): List<String> {
    var ss = ArrayList<String>()
    var sa = ""
    for (c in s.toList()) {
        if (c.isLetter()) {
            sa += c
        } else {
            if (sa.length > 0) {
                ss.add(sa)
                sa = ""
            }
        }
    }
    if (sa.length > 0) {
        ss.add(sa)
    }
    var out = ArrayList<String>()
    for (p in ss.windowed(size = 3)) {
        if (p[0] == a && p[1] == b) {
            out.add(p[2])
        }
    }
    return out.toList()
}

fun main() {

    if (findthird("Perl is a my favourite language but Python is my favourite too.", "my", "favourite") == listOf("language", "too")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (findthird("Barbie is a beautiful doll also also a beautiful princess.", "a", "beautiful") == listOf("doll", "princess")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (findthird("we will we will rock you rock you.", "we", "will") == listOf("we", "rock")) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
