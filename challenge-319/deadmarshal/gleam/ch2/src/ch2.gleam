import gleam/int
import gleam/io
import gleam/list
import gleam/result
import gleam/set

fn minimum_common(l1: List(Int), l2: List(Int)) -> Int {
  let s1 = set.from_list(l1)
  let s2 = set.from_list(l2)
  let s3 = set.intersection(s1, s2)
  list.reduce(set.to_list(s3), fn(x, acc) {
    case x < acc {
      True -> x
      False -> acc
    }
  })
  |> result.unwrap(-1)
}

pub fn main() -> Nil {
  minimum_common([1, 2, 3, 4], [3, 4, 5, 6])
  |> int.to_string
  |> io.println
  minimum_common([1, 2, 3], [2, 4])
  |> int.to_string
  |> io.println
  minimum_common([1, 2, 3, 4], [5, 6, 7, 8])
  |> int.to_string
  |> io.println
  Nil
}
