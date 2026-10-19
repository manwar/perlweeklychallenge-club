import gleam/list
import gleam/set

pub fn finishing_order(order: List(Int), friends: List(Int)) -> List(Int) {
  let s = set.from_list(friends)
  list.filter(order, fn(e) { set.contains(s, e) })
}
