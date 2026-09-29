import gleam/int
import gleam/list
import gleam/string

pub fn prime_step(s: String) -> Int {
  let sum =
    s
    |> string.to_utf_codepoints
    |> list.map(string.utf_codepoint_to_int)
    |> int.sum
  step(sum, 0)
}

fn is_prime(n: Int) -> Bool {
  case n <= 1 {
    True -> False
    False -> !has_divisor(n, 2)
  }
}

fn has_divisor(n: Int, i: Int) -> Bool {
  case i * i > n {
    True -> False
    False ->
      case n % i == 0 {
        True -> True
        False -> has_divisor(n, i + 1)
      }
  }
}

fn step(sum: Int, d: Int) -> Int {
  case is_prime(sum - d) || is_prime(sum + d) {
    True -> d
    False -> step(sum, d + 1)
  }
}
