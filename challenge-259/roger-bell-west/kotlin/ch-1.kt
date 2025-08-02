import java.time.LocalDate
import java.time.format.DateTimeFormatter

fun bankingdayoffset(start: String, offset: Int, bankholidays: List<String>): String {
    val formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd")
    val bh = bankholidays.map {LocalDate.parse(it, formatter)}.toSet()
    var current = LocalDate.parse(start, formatter)
    for (i in 1 .. offset) {
        current = current.plusDays(1)
        while (bh.contains(current) || current.getDayOfWeek().getValue() > 5) {
               current = current.plusDays(1)
        }
    }
    return current.format(formatter)
}

fun main() {

    if (bankingdayoffset("2018-06-28", 3, listOf("2018-07-03")) == "2018-07-04") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (bankingdayoffset("2018-06-28", 3, emptyList<String>()) == "2018-07-03") {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
