use counter::Counter;

#[test]
fn test_ex1() {
    assert_eq!(
        commoncharacters(vec!["java", "javascript", "julia"]),
        vec!['j', 'a']
    );
}

#[test]
fn test_ex2() {
    assert_eq!(
        commoncharacters(vec!["bella", "label", "roller"]),
        vec!['e', 'l', 'l']
    );
}

#[test]
fn test_ex3() {
    assert_eq!(commoncharacters(vec!["cool", "lock", "cook"]), vec!['c', 'o']);
}

fn commoncharacters(a: Vec<&str>) -> Vec<char> {
    let ac =
        a.iter().map(|w| w.chars().collect::<Counter<_>>()).collect::<Vec<_>>();
    let mut vc = ac[0].clone();
    for tc in ac.iter().skip(1) {
        vc = vc & tc.clone();
    }
    let mut out = Vec::new();
    for c in a[0].chars() {
        if vc.contains_key(&c) {
            out.push(c);
            vc.subtract(c.to_string().chars());
        }
    }
    out
}
