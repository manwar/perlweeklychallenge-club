use counter::Counter;

#[test]
fn test_ex1() {
    assert_eq!(specialnotes("abc", "xyz"), false);
}

#[test]
fn test_ex2() {
    assert_eq!(specialnotes("scriptinglanguage", "perl"), true);
}

#[test]
fn test_ex3() {
    assert_eq!(specialnotes("aabbcc", "abc"), true);
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

fn specialnotes(chars: &str, word: &str) -> bool {
    let cm = word2map(chars);
    let f = word2map(word);
    let mut valid = true;
    for c in f.keys() {
        if f.get(c) > cm.get(c) {
            valid = false;
            break;
        }
    }
    valid
}
