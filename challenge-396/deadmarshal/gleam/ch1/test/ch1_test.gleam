import ch1
import gleam/list
import gleeunit
import gleeunit/should

pub fn main() -> Nil {
  gleeunit.main()
}

pub fn hello_world_test() {
  [
    #([3, 1, 4, 2, 5], [1, 2, 4]),
    #([5, 4, 3, 2, 1], [1, 3, 5]),
    #([2, 4, 1, 3], [1, 2, 3, 4]),
    #([4, 1, 3, 2], [3]),
    #([1, 3, 2, 6, 5, 4], [1, 2, 3]),
  ]
  |> list.map(fn(pair) { ch1.finishing_order(pair.0, pair.1) })
  |> should.equal([[1, 4, 2], [5, 3, 1], [2, 4, 1, 3], [3], [1, 3, 2]])
}

