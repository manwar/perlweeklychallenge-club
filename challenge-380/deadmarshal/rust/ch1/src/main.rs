use std::collections::HashMap;

fn sum_of_frequencies(s: &str) -> usize {
    let vowels = ['a', 'e', 'i', 'o', 'u', 'A', 'E', 'I', 'O', 'U'];
    let mut vc: HashMap<char, usize> = HashMap::new();
    let mut cc: HashMap<char, usize> = HashMap::new();
    s.chars().filter(|ch| ch.is_alphabetic()).for_each(|ch| {
        let map = if vowels.contains(&ch) {
            &mut vc
        } else {
            &mut cc
        };
        *map.entry(ch).or_insert(0) += 1;
    });
    let maxv = vc.values().max().unwrap_or(&0);
    let maxc = cc.values().max().unwrap_or(&0);
    maxv + maxc
}

fn main() {}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_sum_frequencies() {
        assert_eq!(sum_of_frequencies("banana"), 5);
        assert_eq!(sum_of_frequencies("teestett"), 7);
        assert_eq!(sum_of_frequencies("aeiouuaa"), 3);
        assert_eq!(sum_of_frequencies("rhythm"), 2);
        assert_eq!(sum_of_frequencies("x"), 1);
    }
}
