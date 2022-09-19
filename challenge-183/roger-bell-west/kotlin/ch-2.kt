import java.time.LocalDate
import java.time.format.DateTimeFormatter
import java.time.temporal.ChronoUnit

fun datedifference(d1s: String, d2s: String): List<Int> {
    val formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd")
    var d1 = LocalDate.parse(d1s, formatter)
    var d2 = LocalDate.parse(d2s, formatter)
    if (d1 > d2) {
        val t = d1
        d1 = d2
        d2 = t
    }
    var yd = d2.getYear() - d1.getYear()
    var inter = LocalDate.of(d2.getYear(), d1.getMonthValue(), d1.getDayOfMonth())
    if (d1.getMonthValue() > d2.getMonthValue() ||
        (d1.getMonthValue() == d2.getMonthValue() &&
         d1.getDayOfMonth() > d2.getDayOfMonth())) {
        inter = LocalDate.of(d2.getYear() - 1, d1.getMonthValue(), d1.getDayOfMonth())
        yd -= 1
    }
    return listOf(yd, ChronoUnit.DAYS.between(inter, d2).toInt())
}

fun main() {
    if (datedifference("2019-02-10", "2022-11-01") == listOf(3, 264)) {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")
    if (datedifference("2020-09-15", "2022-03-29") == listOf(1, 195)) {
        print("Pass")
    } else {
        print("FAIL")
    }
    println("")
}
