import ch1
import gleam/list
import gleeunit
import gleeunit/should

pub fn main() -> Nil {
  gleeunit.main()
}

pub fn digital_root_test() {
  let numbers = [38, 7, 999, 1_999_999_999, 101_010]
  list.map(numbers, fn(n) { ch1.digital_root(n) })
  |> should.equal([#(2, 2), #(0, 7), #(2, 9), #(3, 1), #(1, 3)])
}
