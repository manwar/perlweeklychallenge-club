import ch2
import gleam/list
import gleeunit
import gleeunit/should

pub fn main() -> Nil {
  gleeunit.main()
}

pub fn prime_step_test() {
  ["hello", "football", "a", "challenge", "perl"]
  |> list.map(ch2.prime_step)
  |> should.equal([9, 2, 0, 2, 2])
}
