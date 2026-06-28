import gleam/string

pub fn reverse(xs: String) -> String {
  reverse_go(string.to_graphemes(xs), [])
  |> string.concat
}

fn reverse_go(xs: List(a), ys: List(a)) -> List(a) {
  case xs {
    [] -> ys
    [x, ..rest] -> reverse_go(rest, [x, ..ys])
  }
}

pub fn main() -> Nil {
  assert reverse("") == ""
  assert reverse("reverse the given string") == "gnirts nevig eht esrever"
  assert reverse("Perl is Awesome") == "emosewA si lreP"
  assert reverse("v1.0.0-Beta!") == "!ateB-0.0.1v"
  assert reverse("racecar") == "racecar"
  Nil
}
