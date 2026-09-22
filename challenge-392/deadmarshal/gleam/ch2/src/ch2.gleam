import gleam/int
import gleam/list
import gleam/set
import gleam/string

pub fn words_length_product(xs: List(String)) -> Int {
  find(xs, 0)
}

fn common_letters(s1: String, s2: String) -> Bool {
  let a = set.from_list(string.to_graphemes(s1))
  let b = set.from_list(string.to_graphemes(s2))
  set.size(set.intersection(a, b)) != 0
}

fn find(words: List(String), acc: Int) -> Int {
  case words {
    [] -> acc
    [a, ..rest] -> {
      let acc =
        list.fold(rest, acc, fn(acc, b) {
          case common_letters(a, b) {
            True -> acc
            False -> int.max(acc, string.length(a) * string.length(b))
          }
        })
      find(rest, acc)
    }
  }
}
