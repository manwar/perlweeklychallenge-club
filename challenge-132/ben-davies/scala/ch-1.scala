import java.time.LocalDate
import java.time.format.DateTimeFormatter
import java.time.temporal.ChronoUnit

@main def ch1(input: String) = {
  val formatter = DateTimeFormatter.ofPattern("yyyy/MM/dd")
  val birthday  = LocalDate.parse(input, formatter)
  val today     = LocalDate.of(2021, 9, 22)
  val lifetime  = ChronoUnit.DAYS.between(birthday, today)
  val before    = birthday.minus(lifetime, ChronoUnit.DAYS)
  val after     = today.plus(lifetime, ChronoUnit.DAYS)
  println(before.format(formatter) + ", " + after.format(formatter))
}
