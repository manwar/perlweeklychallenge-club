import gleam/string

pub fn equal_list(left: List(String), right: List(String)) -> Bool {
  string.concat(left) == string.concat(right)
}

pub fn main() -> Nil {
  Nil
}
