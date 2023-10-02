use counter::Counter;
#[test]
fn test_ex1() {
    assert_eq!(goodstrings(vec!["cat", "bt", "hat", "tree"], "atach"), 6);
}

#[test]
fn test_ex2() {
    assert_eq!(
        goodstrings(vec!["hello", "world", "challenge"], "welldonehopper"),
        10
    );
}

fn word2map(word: &str) -> Counter<char> {
    let mut m: Counter<char> = Counter::new();
    for c in word.to_ascii_lowercase().chars() {
        if c >= 'a' && c <= 'z' {
            m[&c] += 1;
        }
    }
    m
}

fn goodstrings(words: Vec<&str>, chars: &str) -> u32 {
    let mut out: u32 = 0;
    let cm = word2map(chars);
    for w in words {
        let f = word2map(w);
        let mut valid = true;
        for c in f.keys() {
            if f.get(c) > cm.get(c) {
                valid = false;
                break;
            }
        }
        if valid {
            out += w.len() as u32;
        }
    }
    out
}
