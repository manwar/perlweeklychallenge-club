import ch1
import gleam/list
import gleeunit
import gleeunit/should

pub fn main() -> Nil {
  gleeunit.main()
}

pub fn absent_smallest_positive_test() {
  [[1, 2, 4, 5, 6], [-5, -2, -1, 3], [1, 2, 3], [2, 3, 7, 8], [1, 1, 1, 10]]
  |> list.map(ch1.absent_smallest_positive)
  |> should.equal([7, 1, 4, 6, 4])
}

