import gleam/dict.{type Dict}
import gleam/list
import gleam/option.{type Option, None, Some}

fn single_common_word(arr1: List(String), arr2: List(String)) -> Int {
  let tally1: Dict(String, Int) =
    arr1
    |> tally
    |> dict.filter(fn(_, v) { v == 1 })

  let tally2: Dict(String, Int) =
    arr2
    |> tally
    |> dict.filter(fn(_, v) { v == 1 })

  dict.combine(tally1, tally2, fn(v1, v2) { v1 + v2 })
  |> dict.filter(fn(_, v) { v == 2 })
  |> dict.keys
  |> list.length
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
  assert single_common_word(["apple", "banana", "cherry"], [
      "banana",
      "cherry",
      "date",
    ])
    == 2

  assert single_common_word(["a", "ab", "abc"], ["a", "a", "ab", "abc"]) == 2

  assert single_common_word(["orange", "lemon"], ["grape", "melon"]) == 0

  assert single_common_word(["test", "test", "demo"], ["test", "demo", "demo"])
    == 0

  assert single_common_word(["Hello", "world"], ["hello", "world"]) == 1

  Nil
}
