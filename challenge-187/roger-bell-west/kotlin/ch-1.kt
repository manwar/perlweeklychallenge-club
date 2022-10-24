import java.time.LocalDate
import java.time.format.DateTimeFormatter
import java.time.temporal.ChronoUnit

fun s2date(ds: String): LocalDate {
    val formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy")
    return LocalDate.parse(ds + "-2022", formatter)
}

fun daystogether(a: List<String>, b: List<String>): Int {
    var starts = listOf(s2date(a[0]), s2date(b[0])).sorted()
    var ends = listOf(s2date(a[1]), s2date(b[1])).sorted()
    if (ends[0] >= starts[1]) {
        return ChronoUnit.DAYS.between(starts[1], ends[0]).toInt()+1
    } else {
        return 0
    }
}

fun main() {
    if (daystogether(listOf("12-01", "20-01"), listOf("15-01", "18-01")) ==
            4) {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")
    if (daystogether(listOf("02-03", "12-03"), listOf("13-03", "14-03")) ==
            0) {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")
    if (daystogether(listOf("02-03", "12-03"), listOf("11-03", "15-03")) ==
            2) {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")
    if (daystogether(listOf("30-03", "05-04"), listOf("28-03", "02-04")) ==
            4) {
        print("Pass")
    } else {
        print("FAIL")
    }
    println("")
}
