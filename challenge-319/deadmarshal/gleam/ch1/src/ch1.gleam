import gleam/int
import gleam/io
import gleam/list
import gleam/string

pub fn is_vowel(s: String) -> Bool {
  case string.lowercase(s) {
    "a" | "e" | "i" | "o" | "u" -> True
    _ -> False
  }
}

fn word_count(l: List(String)) -> Int {
  list.count(l, fn(s) {
    [string.slice(s, 0, 1), string.slice(s, string.length(s) - 1, 1)]
    |> list.any(is_vowel)
  })
}

pub fn main() -> Nil {
  word_count(["unicode", "xml", "raku", "perl"])
  |> int.to_string
  |> io.println
  word_count(["the", "weekly", "challenge"])
  |> int.to_string
  |> io.println
  word_count(["perl", "python", "postgres"])
  |> int.to_string
  |> io.println
  Nil
}
