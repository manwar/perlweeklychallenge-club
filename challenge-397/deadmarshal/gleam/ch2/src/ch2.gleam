import gleam/int
import gleam/list
import gleam/order
import gleam/string

fn reflect(e: Int) -> Int {
  let assert Ok(r) =
    e
    |> int.to_base2
    |> string.reverse
    |> int.base_parse(2)
  r
}

pub fn binary_reflection(xs: List(Int)) -> List(Int) {
  xs
  |> list.map(fn(e) { #(reflect(e), e) })
  |> list.sort(fn(a, b) {
    int.compare(a.0, b.0)
    |> order.break_tie(int.compare(a.1, b.1))
  })
  |> list.map(fn(p) { p.1 })
}
