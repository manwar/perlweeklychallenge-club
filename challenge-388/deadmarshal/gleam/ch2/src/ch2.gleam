import memo.{memo}

pub fn derange(n: Int) -> Int {
  use m <- memo(derange_helper)
  m(n)
}

fn derange_helper(helper: fn(Int) -> Int, n: Int) -> Int {
  case n == 0 {
    True -> 1
    False ->
      n
      * helper(n - 1)
      + case n % 2 == 0 {
        True -> 1
        False -> -1
      }
  }
}

