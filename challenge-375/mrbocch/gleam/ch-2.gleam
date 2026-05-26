import gleam/int
import gleam/list
import gleam/result
import gleam/string

fn k_beauty(num: Int, k: Int) -> Int {
  num
  |> int.to_string
  |> string.to_graphemes
  |> list.window(k)
  |> list.map(string.concat)
  |> list.map(int.parse)
  // impossible for error to happen
  |> result.values
  |> list.filter(fn(n) { num % n == 0 })
  |> list.length
}

pub fn main() {
  assert k_beauty(240, 2) == 2
  assert k_beauty(1020, 2) == 3
  assert k_beauty(444, 2) == 0
  assert k_beauty(17, 2) == 1
  assert k_beauty(123, 1) == 2
}
