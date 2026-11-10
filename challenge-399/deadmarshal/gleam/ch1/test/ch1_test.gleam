import ch1
import gleam/list
import gleeunit
import gleeunit/should

pub fn main() -> Nil {
  gleeunit.main()
}

pub fn longest_repeating_character_test() {
  [
    #("AAAAA", 2),
    #("ABCDE", 4),
    #("AAABBBBAA", 1),
    #("ABACADA", 2),
    #("BAAABAAAA", 1),
  ]
  |> list.map(fn(pair) { ch1.longest_repeating_character(pair.0, pair.1) })
  |> should.equal([5, 5, 5, 5, 8])
}
