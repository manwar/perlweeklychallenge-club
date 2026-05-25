import gleam/int
import gleam/list
import gleam/result
import gleam/string

fn largest_same_dig_n(str: String) -> Int {
  let res: List(Int) =
    str
    |> string.to_graphemes
    |> group
    |> list.map(with: fn(ls) { list.reduce(ls, fn(acc, c) { acc <> c }) })
    |> list.map(with: fn(s) { result.try(s, int.parse) })
    |> result.values

  case list.max(res, int.compare) {
    Ok(n) -> n
    Error(_) -> panic as "Invalid String"
  }
}

fn eq(a: a, b: a) -> Bool {
  a == b
}

fn group(graphemes: List(String)) -> List(List(String)) {
  case list.first(graphemes) {
    Ok(head) -> {
      let p1: List(String) = list.take_while(graphemes, eq(head, _))
      let p2: List(String) = list.drop(graphemes, list.length(p1))
      [p1, ..group(p2)]
    }
    Error(_) -> []
  }
}

pub fn main() -> Nil {
  assert largest_same_dig_n("6777133339") == 3333
  assert largest_same_dig_n("1200034") == 4
  assert largest_same_dig_n("44221155") == 55
  assert largest_same_dig_n("88888") == 88_888
  assert largest_same_dig_n("11122233") == 222
  assert largest_same_dig_n("0000") == 0
  Nil
}
