import gleam/int
import gleam/list
import gleam/order.{type Order, Eq}

pub type Box {
  Box(width: Int, height: Int)
}

pub fn arrange_box(boxes: List(Box)) -> Int {
  let sorted = list.sort(boxes, compare_boxes)
  case sorted {
    [] -> 0
    _ -> {
      list.fold(sorted, [], add_box)
      |> list.map(fn(entry) { entry.1 })
      |> list.fold(1, int.max)
    }
  }
}

fn compare_boxes(a: Box, b: Box) -> Order {
  case int.compare(a.width, b.width) {
    Eq -> int.compare(b.height, a.height)
    other -> other
  }
}

fn add_box(processed: List(#(Box, Int)), box: Box) -> List(#(Box, Int)) {
  let candidates =
    processed
    |> list.filter(fn(entry) {
      let #(prev, _dp) = entry
      prev.width < box.width && prev.height < box.height
    })
    |> list.map(fn(entry) { entry.1 + 1 })

  let dp_i = list.fold(candidates, 1, int.max)
  list.append(processed, [#(box, dp_i)])
}
