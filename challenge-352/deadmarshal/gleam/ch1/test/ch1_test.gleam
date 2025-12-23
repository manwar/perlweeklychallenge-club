import ch1
import gleam/list
import gleeunit
import gleeunit/should

pub fn main() -> Nil {
  gleeunit.main()
}

pub fn ch1_test() {
  [
    ["cat", "cats", "dog", "dogcat", "dogcat", "rat", "ratcatdogcat"],
    ["hello", "hell", "world", "wor", "ellow", "elloworld"],
    ["a", "aa", "aaa", "aaaa"],
    ["flower", "flow", "flight", "fl", "fli", "ig", "ght"],
    ["car", "carpet", "carpenter", "pet", "enter", "pen", "pent"],
  ]
  |> list.map(ch1.match_string)
  |> should.equal([
    ["cat", "dog", "dogcat", "rat"],
    ["hell", "world", "wor", "ellow"],
    ["a", "aa", "aaa"],
    ["flow", "fl", "fli", "ig", "ght"],
    ["car", "pet", "enter", "pen", "pent"],
  ])
}
