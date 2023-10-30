import java.time.LocalDate
import java.time.temporal.ChronoUnit

fun seizetheday(year: Int, month: Int, weekcount: Int, dayofweek: Int): Int {
    var dt = LocalDate.of(year, month, 1)
    var wd = dt.getDayOfWeek().getValue()
    if (wd == 0) {
        wd = 7
    }
    if (wd != dayofweek) {
        dt = dt.plusDays(((dayofweek - wd + 7) % 7).toLong())
    }
    if (weekcount > 1) {
        dt = dt.plusWeeks((weekcount - 1).toLong())
    }
    if (dt.getMonthValue() != month || dt.getYear() != year) {
        return 0
    }
    return dt.getDayOfMonth()
}

fun main() {

    if (seizetheday(2024, 4, 3, 2) == 16) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (seizetheday(2025, 10, 2, 4) == 9) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (seizetheday(2026, 8, 5, 3) == 0) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
