import java.time.LocalDate

fun friday13th(y: Int): Int {
    var f = 0
    for (m in 1..12) {
        if (LocalDate.of(y, m, 13).dayOfWeek.getValue() == 5) {
            f += 1
        }
    }
    return f
}

fun main() {

    if (friday13th(2023) == 2) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
