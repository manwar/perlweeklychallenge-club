import java.time.LocalDate
import java.time.Period
import java.time.format.DateTimeFormatter

fun lastsunday(year0: Int): List<String> {
    var year = year0
    var o = ArrayList<String>()
    val formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd")
    for (month0 in 2..13) {
        var month = month0
        if (month0 == 13) {
            year += 1
            month -= 12
        }
        var dt = LocalDate.of(year,month,1).minusDays(1)
        val dl = dt.dayOfWeek.getValue()
        if (dl < 7) {
            dt = dt.minusDays(dl.toLong())
        }
        o.add(dt.format(formatter))
    }
    return o
}

fun main() {
    if (lastsunday(2022) == listOf( "2022-01-30", "2022-02-27",
                                    "2022-03-27", "2022-04-24",
                                    "2022-05-29", "2022-06-26",
                                    "2022-07-31", "2022-08-28",
                                    "2022-09-25", "2022-10-30",
                                    "2022-11-27", "2022-12-25" )) {
        print("Pass")
    } else {
        print("FAIL")
    }
    println("")
}
