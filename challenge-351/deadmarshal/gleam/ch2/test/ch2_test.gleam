import ch2
import gleam/list
import gleeunit
import gleeunit/should

pub fn main() -> Nil {
  gleeunit.main()
}

pub fn arithmetic_progression_test() {
  [
    [1.0, 3.0, 5.0, 7.0, 9.0],
    [9.0, 1.0, 7.0, 5.0, 3.0],
    [1.0, 2.0, 4.0, 8.0, 16.0],
    [5.0, -1.0, 3.0, 1.0, -3.0],
    [1.5, 3.0, 0.0, 4.5, 6.0],
  ]
  |> list.map(fn(l) { ch2.arithmetic_progression(l) })
  |> should.equal([True, True, False, True, True])
}
