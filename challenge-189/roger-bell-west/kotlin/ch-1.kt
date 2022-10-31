fun greatercharacter(a: List<Char>, k: Char): Char {
    var aa = a.filter{it > k}.sorted()
    if (aa.size > 0) {
        return aa[0]
    } else {
        return k
    }
}

fun main() {
    if (greatercharacter(listOf('e', 'm', 'u', 'g'), 'b') == 'e') {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")   
    if (greatercharacter(listOf('d', 'c', 'e', 'f'), 'a') == 'c') {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")   
    if (greatercharacter(listOf('j', 'a', 'r'), 'o') == 'r') {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")   
    if (greatercharacter(listOf('d', 'c', 'a', 'f'), 'a') == 'c') {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")   
    if (greatercharacter(listOf('t', 'g', 'a', 'l'), 'v') == 'v') {
        print("Pass")
    } else {
        print("FAIL")
    }
    println("")
}
