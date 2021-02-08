use regex::Regex;

// Cargo.toml needs:
// [dependencies]
// regex = "1"

#[test]
fn test_ex1() {
    assert_eq!(pm("abcde","a*e"),1);
}

#[test]
fn test_ex2() {
    assert_eq!(pm("abcde","a*d"),0);
}

#[test]
fn test_ex3() {
    assert_eq!(pm("abcde","?b*d"),0);
}

#[test]
fn test_ex4() {
    assert_eq!(pm("abcde","a*c?e"),1,"example 4");
}

fn pm(text: &str,mat: &str) -> u8 {
    let mut rl: Vec<char>=vec![];
    rl.push('^');
    for c in mat.chars() {
        if c == '?' {
            rl.push('.');
        } else if c == '*' {
            rl.push('.');
            rl.push('*');
        } else {
            rl.push(c);
        }
    }
    rl.push('$');
    let rs=rl.iter().collect::<String>();
    let rx: Regex=Regex::new(&rs).unwrap();
    if rx.is_match(&text) {
        return 1;
    }
    return 0;
}
