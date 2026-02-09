import gleam/int
import gleam/list
import gleam/result
import gleam/string

pub fn digital_root(n: Int) -> #(Int, Int) {
  digital_root_helper(n, 0)
}

fn digital_root_helper(n: Int, pers: Int) -> #(Int, Int) {
  case n, pers {
    n, pers if n < 10 -> #(pers, n)
    _, _ -> {
      let sum = digit_sum(n)
      digital_root_helper(sum, pers + 1)
    }
  }
}

fn digit_sum(n: Int) -> Int {
  let chars = n |> int.to_string |> string.to_graphemes
  list.map(chars, fn(c) {
    int.parse(c)
    |> result.unwrap(0)
  })
  |> list.fold(0, fn(n, acc) { acc + n })
}

pub fn main() -> Nil {
  Nil
}
