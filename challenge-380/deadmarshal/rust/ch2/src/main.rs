fn reverse_degree(s: &str) -> usize {
    s.chars()
        .enumerate()
        .filter(|(_, ch)| ch.is_ascii_lowercase())
        .map(|(i, ch)| {
            let rev_value = 26 - (ch as u8 - b'a') as usize;
            (i + 1) * rev_value
        })
        .sum()
}

fn main() {
    println!("Hello, world!");
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_reverse_degree() {
        assert_eq!(reverse_degree("z"), 1);
        assert_eq!(reverse_degree("a"), 26);
        assert_eq!(reverse_degree("bbc"), 147);
        assert_eq!(reverse_degree("racecar"), 560);
        assert_eq!(reverse_degree("zyx"), 14);
    }
}
