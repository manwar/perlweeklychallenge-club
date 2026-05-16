import gleam/list
import gleam/option.{type Option, None, Some}

fn groups(xs: List(a), n: Int) -> List(List(a)) {
  let first_part = list.take(xs, n)
  let next_part = list.drop(xs, n)

  case xs {
    [] -> []
    // this is kinda ugly
    _ -> [first_part] |> list.append(groups(next_part, n))
  }
}

fn list_division(l: List(a), n: Int) -> Option(List(List(a))) {
  let lenl: Int = list.length(l)
  let group_count_a: Int = lenl % n
  let group_size_b: Int = lenl / n
  let group_size_a: Int = group_size_b + 1
  let total_a: Int = group_count_a * group_size_a

  let group_a: List(List(a)) = groups(list.take(l, total_a), group_size_a)
  let group_b: List(List(a)) = groups(list.drop(l, total_a), group_size_b)

  case n <= 0 || list.length(l) < n {
    True -> None
    False -> Some(list.append(group_a, group_b))
  }
}

pub fn main() -> Nil {
  assert list_division([1, 2, 3, 4, 5], 2) == Some([[1, 2, 3], [4, 5]])
  assert list_division([1, 2, 3, 4, 5, 6], 3) == Some([[1, 2], [3, 4], [5, 6]])
  assert list_division([1, 2, 3], 2) == Some([[1, 2], [3]])
  assert list_division([1, 2, 3, 4, 5, 6, 7, 8, 9, 10], 5)
    == Some([[1, 2], [3, 4], [5, 6], [7, 8], [9, 10]])
  assert list_division([1, 2, 3], 4) == None
  assert list_division([72, 57, 89, 55, 36, 84, 10, 95, 99, 35], 7)
    == Some([[72, 57], [89, 55], [36, 84], [10], [95], [99], [35]])
}
