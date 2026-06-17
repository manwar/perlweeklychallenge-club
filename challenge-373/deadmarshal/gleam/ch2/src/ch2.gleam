import gleam/list
import gleam/option.{type Option, None, Some}

fn groups(xs: List(a), n: Int) -> List(List(a)) {
  let left = list.take(xs, n)
  let right = list.drop(xs, n)
  case xs {
    [] -> []
    _ -> list.append([left],groups(right, n))
  }
}

pub fn list_division(xs: List(a), n: Int) -> Option(List(List(a))) {
  let len = list.length(xs)
  let group_count_a = len % n
  let group_size_b = len / n
  let group_size_a = group_size_b + 1
  let total_a = group_count_a * group_size_a
  let group_a = groups(list.take(xs, total_a), group_size_a)
  let group_b = groups(list.drop(xs, total_a), group_size_b)

  case n <= 0 || list.length(xs) < n {
    True -> None
    False -> Some(list.append(group_a, group_b))
  }
}

pub fn main() -> Nil {
  Nil
}
