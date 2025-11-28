import ch1
import gleam/list
import gleeunit
import gleeunit/should

pub fn main() -> Nil {
  gleeunit.main()
}

pub fn example_test() {
  ["textbook", "aaaaa", "hoorayyy", "x", "aabcccddeeffffghijjk"]
  |> list.map(ch1.power_string)
  |> should.equal([2, 5, 3, 1, 4])
}
