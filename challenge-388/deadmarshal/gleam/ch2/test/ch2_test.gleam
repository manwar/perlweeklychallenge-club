import ch2
import gleam/list
import gleeunit
import gleeunit/should

pub fn main() -> Nil {
  gleeunit.main()
}

pub fn derange_test() {
  [1, 2, 3, 4, 5]
  |> list.map(fn(e) { ch2.derange(e) })
  |> should.equal([0, 1, 2, 9, 44])
}
