import java.time.LocalDateTime
import java.time.format.DateTimeFormatter
import java.time.temporal.ChronoUnit

fun addbizhours(start: String, delta: Double): String {
    val formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm")
    var current = LocalDateTime.parse(start, formatter)
    var seconds = (delta * 3600.0).toInt();
    val bizdaylength = 3600 * 9
    if (!isbiz(current)) {
        current = nextbizstart(current)
    }
    val ed = nextbizend(current)
    var remain = ChronoUnit.SECONDS.between(current, ed).toInt()
    if (remain < seconds) {
        seconds -= remain
        current = nextbizstart(ed)
        while (seconds > bizdaylength) {
            current = nextbizstart(current)
            seconds -= bizdaylength
            }
        }
    current = current.plusSeconds(seconds.toLong())
    return current.format(formatter)
}

fun isbiz(tm: LocalDateTime): Boolean {
    if (tm.getDayOfWeek().getValue() > 5) {
        return false
    }
    if (tm.getHour() < 9 || tm.getHour() >= 18) {
        return false
    }
    return true
}

fun nextbizstart(tm0: LocalDateTime): LocalDateTime {
    var tm = tm0
    while (tm.getDayOfWeek().getValue() > 5) {
        tm = tm.plusDays(1).withHour(9).withMinute(0).withSecond(0)
    }
    if (tm.getHour() < 9) {
        tm = tm.withHour(9).withMinute(0).withSecond(0)
    } else {
        while (true) {
            tm = tm.plusDays(1).withHour(9).withMinute(0).withSecond(0)
            if (tm.getDayOfWeek().getValue() < 6) {
                break
            }
        }
    }
    return tm
}

fun nextbizend(tm0: LocalDateTime): LocalDateTime {
    var tm = tm0
    while (tm.getDayOfWeek().getValue() > 5) {
        tm = tm.plusDays(1).withHour(18).withMinute(0).withSecond(0)
    }
    if (tm.getHour() >= 18) {
        while (true) {
            tm = tm.plusDays(1).withHour(18).withMinute(0).withSecond(0)
            if (tm.getDayOfWeek().getValue() < 6) {
                break
            }
        }
    } else {
        tm = tm.withHour(18).withMinute(0).withSecond(0)
    }
    return tm
}

fun main() {
    if (addbizhours("2022-08-01 10:30", 4.0) == "2022-08-01 14:30") {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")
    if (addbizhours("2022-08-01 17:00", 3.5) == "2022-08-02 11:30") {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")
    if (addbizhours("2022-08-01 18:00", 3.5) == "2022-08-02 12:30") {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")
    if (addbizhours("2022-08-01 19:00", 3.5) == "2022-08-02 12:30") {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")
    if (addbizhours("2022-08-05 17:00", 3.5) == "2022-08-08 11:30") {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")
    if (addbizhours("2022-08-01 12:00", 18.0) == "2022-08-03 12:00") {
        print("Pass")
    } else {
        print("FAIL")
    }
    println("")
}
