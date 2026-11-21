import ch1
import gleam/list
import gleeunit
import gleeunit/should

pub fn main() -> Nil {
  gleeunit.main()
}

pub fn largest_interval_test() {
  [20, 110, 500, 2026, 10_000]
  |> list.map(ch1.largest_interval)
  |> should.equal([2, 4, 11, 105, 105])
}
