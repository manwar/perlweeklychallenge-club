import ch2
import gleam/list
import gleeunit
import gleeunit/should

pub fn main() -> Nil {
  gleeunit.main()
}

pub fn ch2_test() {
  [
    [0, 1, 1, 0, 0, 1, 0, 1, 1, 1],
    [1, 0, 1, 0, 1, 0],
    [0, 0, 1, 0, 1],
    [1, 1, 1, 1, 1],
    [1, 0, 1, 1, 0, 1, 0, 0, 1, 1],
  ]
  |> list.map(ch2.binary_prefix)
  |> should.equal([
    [True, False, False, False, False, True, True, False, False, False],
    [False, False, True, True, False, False],
    [True, True, False, False, True],
    [False, False, False, True, False],
    [False, False, True, False, False, True, True, True, False, False],
  ])
}
