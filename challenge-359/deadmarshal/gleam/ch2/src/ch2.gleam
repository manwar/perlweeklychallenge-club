import gleam/list
import gleam/string

pub fn string_reduction(s: String) -> String {
  reduce(s |> string.to_graphemes, [])
  |> list.reverse
  |> string.join("")
}

fn reduce(cs: List(String), acc: List(String)) -> List(String) {
  case cs, acc {
    [], acc -> acc
    [c, ..rest], [] -> reduce(rest, [c])
    [c1, ..rest], [c2, ..acc_rest] if c1 == c2 -> reduce(rest, acc_rest)
    [c, ..rest], acc -> reduce(rest, [c, ..acc])
  }
}

pub fn main() -> Nil {
  Nil
}
