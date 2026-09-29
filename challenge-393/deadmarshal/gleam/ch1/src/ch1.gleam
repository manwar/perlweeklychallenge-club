pub fn pythagoras_multiplied(n: Int) -> Int {
  outer(2, n, 0)
}

fn outer(m: Int, n: Int, count: Int) -> Int {
  case m * m + 1 <= n {
    True -> outer(m + 1, n, inner(m, 1, n, count))
    False -> count
  }
}

fn inner(m: Int, k: Int, n: Int, count: Int) -> Int {
  case k >= m {
    True -> count
    False -> {
      let c = m * m + k * k
      let add = case { m - k } % 2 == 1 && c <= n && gcd(m, k) == 1 {
        True -> 2 * { n / c }
        False -> 0
      }
      inner(m, k + 1, n, count + add)
    }
  }
}

fn gcd(a: Int, b: Int) -> Int {
  case a, b {
    a, 0 -> a
    _, _ -> gcd(b, a % b)
  }
}
