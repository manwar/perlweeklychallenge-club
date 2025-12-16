import gleam/int
import gleam/list

pub fn binary_prefix(l: List(Int)) -> List(Bool) {
  let #(res, _) =
    list.fold(l, #([], 0), fn(acc, e) {
      let #(acc, x) = acc
      let newx = { int.bitwise_shift_left(x, 1) |> int.bitwise_or(e) } % 5
      #([newx == 0, ..acc], newx)
    })
  res |> list.reverse
}

pub fn main() -> Nil {
  Nil
}
