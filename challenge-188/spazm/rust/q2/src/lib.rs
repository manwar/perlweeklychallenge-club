///
///
///
/// You are given two positive integers $x and $y.
///
/// Write a script to find out the number of operations needed to make both ZERO. Each operation is
/// made up either of the followings:
///
/// $x = $x - $y if $x >= $y
///
/// or
///
/// $y = $y - $x if $y >= $x (using the original value of $x)
///
/// ```
/// use q2::total_zero;
/// let val = total_zero(5, 4);
/// # assert_eq!(val, 5);
/// ```
pub fn total_zero(x: i32, y: i32) -> i32 {
    assert!(x > 0);
    assert!(y > 0);
    1 + match (x, y) {
        (x, y) if x > y => total_zero(x - y, y),
        (x, y) if x < y => total_zero(x, y - x),
        _ => 0,
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn it_works() {
        let result = total_zero(5, 4);
        assert_eq!(result, 5);
        let result = total_zero(4, 6);
        assert_eq!(result, 3);
        let result = total_zero(2, 5);
        assert_eq!(result, 4);
        let result = total_zero(3, 1);
        assert_eq!(result, 3);
        let result = total_zero(7, 4);
        assert_eq!(result, 5);
    }
    #[test]
    #[should_panic]
    fn it_panics() {
        total_zero(-7, 4);
    }
}
