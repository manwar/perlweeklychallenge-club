// Cargo.toml needs:
// [dependencies]
// regex = "1"

use regex::Regex;

#[test]
fn test_ex1() {
    assert_eq!(capitaldetection("Perl"), true);
}

#[test]
fn test_ex2() {
    assert_eq!(capitaldetection("TPF"), true);
}

#[test]
fn test_ex3() {
    assert_eq!(capitaldetection("PyThon"), false);
}

#[test]
fn test_ex4() {
    assert_eq!(capitaldetection("raku"), true);
}

fn capitaldetection(s: &str) -> bool {
    let re = Regex::new(r"^([A-Z]+|[a-z]+|[A-Z][a-z]+)$").unwrap();
    re.is_match(s)
}
