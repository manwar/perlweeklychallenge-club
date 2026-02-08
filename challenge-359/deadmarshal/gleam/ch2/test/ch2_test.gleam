import ch2
import gleam/list
import gleeunit
import gleeunit/should

pub fn main() -> Nil {
  gleeunit.main()
}

pub fn string_reduction_test() {
  let tests = ["aabbccdd", "abccba", "abcdef", "aabbaeaccdd", "mississippi"]
  list.map(tests, fn(t) { ch2.string_reduction(t) })
  |> should.equal(["", "", "abcdef", "aea", "m"])
}
