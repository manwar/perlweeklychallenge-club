import gleam/list
import gleam/string

fn f(s: String) -> Int {
  let chars = string.to_graphemes(s)
  list.fold(chars, 0, fn(acc, c) {
    let assert [cc] =
      c |> string.to_utf_codepoints |> list.map(string.utf_codepoint_to_int)
    acc * 10 + { cc - 97 }
  })
}

pub fn sum_of_words(s1: String, s2: String, s3: String) -> Bool {
  f(s1) + f(s2) == f(s3)
}

pub fn main() -> Nil {
  Nil
}
