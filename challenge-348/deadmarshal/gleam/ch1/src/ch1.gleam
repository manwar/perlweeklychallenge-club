import gleam/bool
import gleam/io
import gleam/list
import gleam/set
import gleam/string

fn count_vowels(s: String) -> Int {
  let vowels = set.from_list("aeiouAEIOU" |> string.to_graphemes)
  list.fold(s |> string.to_graphemes, 0, fn(acc, c) {
    case set.contains(vowels, c) {
      True -> acc + 1
      False -> acc
    }
  })
}

fn string_alike(s: String) -> Bool {
  let n = string.length(s)
  let half = n / 2
  let #(first, second) = #(string.slice(s, 0, half), string.slice(s, half, n))
  let c1 = count_vowels(first)
  let c2 = count_vowels(second)
  c1 == c2 && c1 != 0
}

pub fn main() -> Nil {
  list.each(
    ["textbook", "book", "AbCdEfGh", "rhythmmyth", "UmpireeAudio"],
    fn(s) { s |> string_alike |> bool.to_string |> io.println },
  )
}
