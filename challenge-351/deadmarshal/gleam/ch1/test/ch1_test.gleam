import ch1
import gleam/list
import gleeunit
import gleeunit/should

pub fn main() -> Nil {
  gleeunit.main()
}

pub fn special_average_test() {
  [
    [8000, 5000, 6000, 2000, 3000, 7000],
    [100_000, 80_000, 110_000, 90_000],
    [2500, 2500, 2500, 2500],
    [2000],
    [1000, 2000, 3000, 4000, 5000, 6000],
  ]
  |> list.map(fn(l) { ch1.special_average(l) })
  |> should.equal([5250, 95_000, 2500, 0, 3500])
}
