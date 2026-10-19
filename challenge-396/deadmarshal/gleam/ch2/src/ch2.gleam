import gleam/list

fn sign(x: Int) -> Int {
  case x {
    _ if x < 0 -> -1
    _ if x > 0 -> 1
    _ -> 0
  }
}

pub fn trionic_list(xs: List(Int)) -> Bool {
  let signs =
    xs |> list.window_by_2 |> list.map(fn(pair) { sign(pair.1 - pair.0) })
  dedup(signs) == [1, -1, 1]
}

fn dedup(xs: List(a)) -> List(a) {
  case xs {
    [] -> []
    [h, ..t] -> [h, ..dedup(drop_while(h, t))]
  }
}

fn drop_while(x: a, xs: List(a)) -> List(a) {
  case xs {
    [y, ..t] if y == x -> drop_while(x, t)
    _ -> xs
  }
}
