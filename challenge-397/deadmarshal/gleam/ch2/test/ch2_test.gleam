import ch2
import gleam/list
import gleeunit
import gleeunit/should

pub fn main() -> Nil {
  gleeunit.main()
}

pub fn binary_reflection_test() {
  [[3, 6, 12], [1, 2, 4, 8], [7, 8, 9, 10], [5, 9, 15, 17], [11, 13, 14, 19]]
  |> list.map(ch2.binary_reflection)
  |> should.equal([
    [3, 6, 12],
    [1, 2, 4, 8],
    [8, 10, 7, 9],
    [5, 9, 15, 17],
    [14, 13, 11, 19],
  ])
}

