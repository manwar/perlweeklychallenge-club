use counter::Counter;

#[test]
fn test_ex1() {
    assert_eq!(
        commoncharacters(vec!["bella", "label", "roller"]),
        vec!["e", "l", "l"]
    );
}

#[test]
fn test_ex2() {
    assert_eq!(commoncharacters(vec!["cool", "lock", "cook"]), vec!["c", "o"]);
}

#[test]
fn test_ex3() {
    assert_eq!(
        commoncharacters(vec!["hello", "world", "pole"]),
        vec!["l", "o"]
    );
}

#[test]
fn test_ex4() {
    assert_eq!(
        commoncharacters(vec!["abc", "def", "ghi"]),
        Vec::<String>::new()
    );
}

#[test]
fn test_ex5() {
    assert_eq!(commoncharacters(vec!["aab", "aac", "aaa"]), vec!["a", "a"]);
}

fn commoncharacters(a: Vec<&str>) -> Vec<String> {
    let mut mc: Counter<char> = Counter::new();
    let mut first = true;
    for s in a {
        let mk = s.chars().collect::<Counter<_>>();
        if first {
            mc = mk;
            first = false;
        } else {
            mc = mc & mk;
        }
    }
    let mut out = Vec::new();
    let mut kl = mc.keys().collect::<Vec<_>>();
    kl.sort();
    for c in kl {
        for _ in 0..*mc.get(&c).unwrap() {
            out.push(c.to_string());
        }
    }
    out
}
