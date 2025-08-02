fun noconnection(a: List<List<Char>>): Char {
    val os = a.map{it[0]}.toSet()
    val iis = a.map{it[1]}.toSet()
    return iis.subtract(os).toList()[0]
}

fun main() {

    if (noconnection(listOf(listOf('B', 'C'), listOf('D', 'B'), listOf('C', 'A'))) == 'A') {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (noconnection(listOf(listOf('A', 'Z'))) == 'Z') {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
