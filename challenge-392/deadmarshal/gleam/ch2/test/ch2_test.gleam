import ch2.{words_length_product}
import gleam/list
import gleeunit
import gleeunit/should

pub fn main() -> Nil {
  gleeunit.main()
}

pub fn hello_world_test() {
  [
    ["a", "ab", "abc", "d", "de", "def"],
    ["a", "aa", "aaa", "aaaa"],
    ["meet", "app", "code", "sky", "bold"],
    ["a", "ab", "abc", "abcd", "efghi"],
    ["xyz", "w", "abcdefg", "hij"],
  ]
  |> list.map(words_length_product)
  |> should.equal([9, 0, 16, 20, 21])
}
