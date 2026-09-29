import ch1
import gleam/list
import gleeunit
import gleeunit/should

pub fn main() -> Nil {
  gleeunit.main()
}

pub fn pythagoras_multiplied_test() {
  [20, 7, 1, 15, 30]
  |> list.map(ch1.pythagoras_multiplied)
  |> should.equal([12, 2, 0, 8, 22])
}
