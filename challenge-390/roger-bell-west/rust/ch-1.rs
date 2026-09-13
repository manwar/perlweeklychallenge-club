use regex::Regex;

#[test]
fn test_ex1() {
    assert_eq!(decodestring("2[3[a]]"), "aaaaaa");
}

#[test]
fn test_ex2() {
    assert_eq!(decodestring("10[a]"), "aaaaaaaaaa");
}

#[test]
fn test_ex3() {
    assert_eq!(decodestring("a2[b]c3[d]e"), "abbcddde");
}

#[test]
fn test_ex4() {
    assert_eq!(decodestring("2[a2[b]c]"), "abbcabbc");
}

#[test]
fn test_ex5() {
    assert_eq!(decodestring("1[a]2[b3[c]]"), "abcccbccc");
}

fn decodestring(a0: &str) -> String {
    let mut a = a0.to_string();
    let re = Regex::new(r"([0-9]+)\[([^\[\]]*)\]").unwrap();
    loop {
        let mut b = a.clone();
        if re.is_match(&a) {
            if let Some(caps) = re.captures(&a) {
                let orig = caps.get(0).unwrap().as_str();
                let ct =
                    caps.get(1).unwrap().as_str().parse::<usize>().unwrap();
                let rep = caps.get(2).unwrap().as_str().repeat(ct);
                b = a.replace(orig, &rep).clone();
            }
        } else {
            break;
        }
        a = b.clone();
    }
    a
}
