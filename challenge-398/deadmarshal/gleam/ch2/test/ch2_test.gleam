import ch2
import gleam/list
import gleeunit
import gleeunit/should

pub fn main() -> Nil {
  gleeunit.main()
}

pub fn string_difference_test() {
  [
    ["ab", "bc", "cd", "zy"],
    ["cba", "fed", "azy"],
    ["pop", "ada", "beb", "cfc"],
    ["aaaa", "zzzz", "mmmm", "aaba"],
    ["aceg", "bdfh", "cegi", "azbz"],
  ]
  |> list.map(ch2.string_difference)
  |> should.equal([Ok("zy"), Ok("azy"), Ok("pop"), Ok("aaba"), Ok("azbz")])
}

