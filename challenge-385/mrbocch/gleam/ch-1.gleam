import gleam/dict.{type Dict}
import gleam/option.{type Option, None, Some}
import gleam/set.{type Set}
import gleam/string

fn uncommon_words(s1: String, s2: String) -> Set(String) {
  let x = tally(string.split(s1, " "))
  let y = tally(string.split(s2, " "))
  dict.combine(x, y, fn(a, b) { a + b })
  |> dict.filter(fn(_, v) { v == 1 })
  |> dict.keys
  |> set.from_list
}

fn tally(xs: List(a)) -> Dict(a, Int) {
  let tally: Dict(a, Int) = dict.new()
  tally_dict(xs, tally)
}

fn increment(a: Option(Int)) -> Int {
  case a {
    Some(a) -> a + 1
    None -> 1
  }
}

fn tally_dict(xs: List(a), dic: Dict(a, Int)) -> Dict(a, Int) {
  case xs {
    [] -> dic
    [x, ..rest] -> {
      let updated = dict.upsert(dic, x, increment)
      tally_dict(rest, updated)
    }
  }
}

pub fn main() -> Nil {
  assert uncommon_words("apple banana apple", "banana orange")
    == set.from_list(["orange"])

  assert uncommon_words("cat dog", "bird fish")
    == set.from_list(["cat", "dog", "bird", "fish"])

  assert uncommon_words("the quick brown fox", "the quick")
    == set.from_list(["brown", "fox"])

  assert uncommon_words("hello", "hello") == set.from_list([])

  assert uncommon_words("blue blue red", "red green green yellow")
    == set.from_list(["yellow"])

  echo "All test pass"
  Nil
}
