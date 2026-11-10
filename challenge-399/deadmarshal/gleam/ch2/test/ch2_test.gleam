import ch2
import gleam/list
import gleeunit
import gleeunit/should

pub fn main() -> Nil {
  gleeunit.main()
}

pub fn longest_absolute_path_test() {
  [
    "dir\n\tsubdir1\n\t\tsubsubdir1\n\tsubdir2",
    "file1.txt\nfile2.ext\na.png",
    "my documents\n\tproject v1.0\n\t\tnotes v1.txt\n\timage.png",
    "root\n\ta\n\t\tb\n\t\t\tc.txt\n\td\n\t\te.txt",
    "a\n\tb\n\t\tc\n\t\t\td\n\t\t\t\te.txt\n\tvery_long_directory_name\n\t\tf.txt",
  ]
  |> list.map(ch2.longest_absolute_path)
  |> should.equal([0, 9, 38, 14, 32])
}
