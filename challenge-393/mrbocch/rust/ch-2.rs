use std::cmp::min;
use use_prime::{is_prime, next_prime, previous_prime};

fn main() {}

fn prime_step(s: String) -> u64 {
    let sum = s.chars().map(|c| c as u64).sum::<u64>();

    match is_prime(sum) {
        true => 0,
        false => {
            let prev = previous_prime(sum).unwrap();
            let next = next_prime(sum).unwrap();
            min(sum.abs_diff(prev), sum.abs_diff(next))
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_hello() {
        assert_eq!(prime_step(String::from("hello")), 9);
    }

    #[test]
    fn test_football() {
        assert_eq!(prime_step(String::from("football")), 2);
    }

    #[test]
    fn test_a() {
        assert_eq!(prime_step(String::from("a")), 0);
    }

    #[test]
    fn test_challenge() {
        assert_eq!(prime_step(String::from("challenge")), 2);
    }

    #[test]
    fn test_perl() {
        assert_eq!(prime_step(String::from("perl")), 2);
    }
}
