import ch2
import gleam/option.{None, Some}
import gleeunit
import gleeunit/should

pub fn main() -> Nil {
  gleeunit.main()
}

pub fn list_division_test() {
  should.equal(
    [
      ch2.list_division([1, 2, 3, 4, 5], 2),
      ch2.list_division([1, 2, 3, 4, 5, 6], 3),
      ch2.list_division([1, 2, 3], 2),
      ch2.list_division([1, 2, 3, 4, 5, 6, 7, 8, 9, 10], 5),
      ch2.list_division([1, 2, 3], 4),
      ch2.list_division([72, 57, 89, 55, 36, 84, 10, 95, 99, 35], 7),
    ],
    [
      Some([[1, 2, 3], [4, 5]]),
      Some([[1, 2], [3, 4], [5, 6]]),
      Some([[1, 2], [3]]),
      Some([[1, 2], [3, 4], [5, 6], [7, 8], [9, 10]]),
      None,
      Some([[72, 57], [89, 55], [36, 84], [10], [95], [99], [35]]),
    ],
  )
}
