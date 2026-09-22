import ch1.{convert_palindrome}
import gleam/list
import gleeunit
import gleeunit/should

pub fn main() -> Nil {
  gleeunit.main()
}

pub fn convert_palindrome_test() {
  ["pinnipeds", "abcd", "bananas", "dissident", "cailliachs"]
  |> list.map(convert_palindrome)
  |> should.equal([
    "sdepinnipeds",
    "dcbabcd",
    "sananabananas",
    "tnedissident",
    "shcailliachs",
  ])
}
