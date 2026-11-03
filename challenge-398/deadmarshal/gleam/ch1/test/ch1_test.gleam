import ch1
import gleam/list
import gleeunit
import gleeunit/should

pub fn main() -> Nil {
  gleeunit.main()
}

pub fn divisible_average_test() {
  [
    [18, 5, 7, 11],
    [6, 12, 18, 24, 30, 40],
    [3, 9, 15, 21, 27],
    [6, 12, 14, 20],
    [6, 6, 6, 12, 12],
  ]
  |> list.map(ch1.divisible_average)
  |> should.equal([18, 18, 0, 9, 8])
}
