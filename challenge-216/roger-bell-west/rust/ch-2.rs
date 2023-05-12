use counter::Counter;
use std::collections::VecDeque;

#[test]
fn test_ex1() {
    assert_eq!(wordstickers(vec!["perl", "raku", "python"], "peon"), 2);
}

#[test]
fn test_ex2() {
    assert_eq!(wordstickers(vec!["love", "hate", "angry"], "goat"), 3);
}

#[test]
fn test_ex3() {
    assert_eq!(
        wordstickers(vec!["come", "nation", "delta"], "accomodation"),
        4
    );
}

#[test]
fn test_ex4() {
    assert_eq!(
        wordstickers(vec!["come", "country", "delta"], "accomodation"),
        0
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

fn wordstickers(stickers: Vec<&str>, word: &str) -> u32 {
    let w = word2map(word);
    let mut t = w.clone();
    let mut stick: Vec<Counter<char>> = Vec::new();
    for s in stickers {
        let f = word2map(s);
        for c in f.keys() {
            t.remove(c);
        }
        stick.push(f);
    }
    if t.len() > 0 {
        return 0;
    }
    let mut stack = VecDeque::new();
    stack.push_back((w, 0));
    while stack.len() > 0 {
        let st = stack.pop_front().unwrap();
        if st.0.len() == 0 {
            return st.1;
        } else {
            let n = st.1 + 1;
            for sti in &stick {
                let mut sp = st.0.clone();
                let mut v = false;
                for l in sti.keys() {
                    if sp.contains_key(l) {
                        v = true;
                        let p: i32 = *sp.get(l).unwrap() as i32
                            - *sti.get(l).unwrap() as i32;
                        if p > 0 {
                            sp.insert(*l, p as usize);
                        } else {
                            sp.remove(l);
                        }
                    }
                }
                if v {
                    stack.push_back((sp, n));
                }
            }
        }
    }
    0
}
