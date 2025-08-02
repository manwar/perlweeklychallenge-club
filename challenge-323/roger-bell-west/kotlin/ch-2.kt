fun taxamount(income: Int, brackets: List<List<Int>>): Double {
    var tax = 0
    var lastbracket = 0
    for (bracket in brackets) {
        if (income > lastbracket) {
            tax += (listOf(income, bracket[0]).minOrNull()!! - lastbracket) * bracket[1]
        }
        lastbracket = bracket[0]
    }
    return tax.toDouble() / 100.0
}

fun main() {

    if (taxamount(10, listOf(listOf(3, 50), listOf(7, 10), listOf(12, 25))) == 2.65) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (taxamount(2, listOf(listOf(1, 0), listOf(4, 25), listOf(5, 50))) == 0.25) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (taxamount(0, listOf(listOf(2, 50))) == 0.0) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
