import gleam/list
import gleam/result

// my implementation of gleam/string.{concat}
fn concat(s: List(String)) -> String {
  let append = fn(s1, s2) { s1 <> s2 }
  list.reduce(s, append)
  |> result.unwrap("")
}

fn equal_list(s1: List(String), s2: List(String)) -> Bool {
  concat(s1) == concat(s2)
}

pub fn main() -> Nil {
  assert equal_list(["a", "bc"], ["ab", "c"]) == True
  assert equal_list(["a", "bc"], ["ab", "c"]) == True
  assert equal_list(["a", "b", "c"], ["a", "bc"]) == True
  assert equal_list(["a", "bc"], ["a", "c", "b"]) == False
  assert equal_list(["ab", "c"], ["", "a", "bc"]) == True
  assert equal_list(["p", "e", "r", "l"], ["perl"]) == True
}
