import gleam/int
import gleam/list
import gleam/result
import gleam/set
import gleam/string

fn count_vowel(s: String) -> List(String) {
  s
  |> string.to_graphemes
  |> sublists
  |> list.filter(fn(x) { list.length(x) >= 5 })
  |> list.map(fn(x) { list.reduce(x, fn(acc, xs) { acc <> xs }) })
  |> result.values
  |> list.filter(all_vowels)
}

fn sublists(xs: List(a)) -> List(List(a)) {
  let takers: List(Int) =
    int.range(from: list.length(xs), to: 0, with: [], run: list.prepend)

  let p1: List(List(a)) = takers |> list.map(fn(x) { list.take(xs, x) })
  case xs {
    [] -> []
    [_, ..rest] -> p1 |> list.append(sublists(rest))
  }
}

fn all_vowels(s: String) -> Bool {
  all_vowels_t(s, #(0, 0, 0, 0, 0))
}

fn all_vowels_t(s: String, counter: #(Int, Int, Int, Int, Int)) -> Bool {
  let #(a, e, i, o, u) = counter
  case s {
    "" -> {
      counter.0 > 0
      && counter.1 > 0
      && counter.2 > 0
      && counter.3 > 0
      && counter.4 > 0
    }
    "a" <> rest -> all_vowels_t(rest, #(a + 1, e, i, o, u))
    "e" <> rest -> all_vowels_t(rest, #(a, e + 1, i, o, u))
    "i" <> rest -> all_vowels_t(rest, #(a, e, i + 1, o, u))
    "o" <> rest -> all_vowels_t(rest, #(a, e, i, o + 1, u))
    "u" <> rest -> all_vowels_t(rest, #(a, e, i, o, u + 1))
    _ -> False
  }
}

pub fn main() -> Nil {
  let a = set.from_list(count_vowel("aeiou"))
  let b = set.from_list(count_vowel("aaeeeiioouu"))
  let c = set.from_list(count_vowel("aeiouuaxaeiou"))
  let d = set.from_list(count_vowel("uaeiou"))
  let e = set.from_list(count_vowel("aeioaeioa"))

  let a1 = set.from_list(["aeiou"])
  let b1 =
    set.from_list(["aaeeeiioou", "aaeeeiioouu", "aeeeiioou", "aeeeiioouu"])
  let c1 = set.from_list(["aeiou", "aeiou", "eiouua", "aeiouu", "aeiouua"])
  let d1 = set.from_list(["aeiou", "uaeio", "uaeiou"])
  let e1 = set.from_list([])

  assert a == a1
  assert b == b1
  assert c == c1
  assert d == d1
  assert e == e1

  Nil
}
