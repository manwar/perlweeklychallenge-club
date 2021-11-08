use regex::Regex;

#[test]
fn test_ex1() {
    assert_eq!(sw(5),13);
}

#[test]
fn test_ex2() {
    assert_eq!(sw(10),32);
}

#[test]
fn test_ex3() {
    assert_eq!(sw(60),2223);
}

fn sw (cc: u32) -> u32 {
    let mut c=cc;
    let mut n=0;
    let p=Regex::new(r"([04-9]|11)").unwrap();
    while c>0 {
        n+=1;
        if p.is_match(&n.to_string()) {
            continue;
        }
        c-=1;
    }
    return n;
}
