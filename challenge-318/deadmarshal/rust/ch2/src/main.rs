fn reverse_equals<T: std::cmp::PartialEq>(src: &[T], target: &[T]) -> bool {
  if src.len() != target.len() {
    return false;
  }

  let mut from: Option<usize> = None;
  let mut to: Option<usize> = None;

  for i in 0..src.len() {
    if src[i] != target[i] {
      from = Some(i);
      break;
    }
  }

  if from.is_none() {
    return true;
  }

  for i in (from.unwrap()..src.len()).rev() {
    if src[i] != target[i] {
      to = Some(i);
      break;
    }
  }

  for i in 0..to.unwrap() - from.unwrap() {
    if src[from.unwrap() + i] != target[to.unwrap() - i] {
      return false;
    }
  }
  true
}

fn main() {
  println!("{}", reverse_equals(&[3, 2, 1, 4], &[1, 2, 3, 4]));
  println!("{}", reverse_equals(&[1, 3, 5], &[4, 1, 3]));
  println!("{}", reverse_equals(&[2], &[2]));
}

