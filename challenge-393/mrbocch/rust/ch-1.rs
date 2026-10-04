fn main() {}

fn pythagoras_multiplied(n: u32) -> u32 {
    let mut count = 0;
    for a in 1..=n {
        for b in 1..=n {
            for c in 1..=n {
                count += if a.pow(2) + b.pow(2) == c.pow(2) {
                    1
                } else {
                    0
                };
            }
        }
    }

    count
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_n_20() {
        assert_eq!(pythagoras_multiplied(20), 12);
    }

    #[test]
    fn test_n_7() {
        assert_eq!(pythagoras_multiplied(7), 2);
    }

    #[test]
    fn test_n_1() {
        assert_eq!(pythagoras_multiplied(1), 0);
    }

    #[test]
    fn test_n_15() {
        assert_eq!(pythagoras_multiplied(15), 8);
    }

    #[test]
    fn test_n_30() {
        assert_eq!(pythagoras_multiplied(30), 22);
    }
}
