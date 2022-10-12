use any_ascii::any_ascii;

#[test]
fn test_ex1() {
    assert_eq!(any_ascii("ÃÊÍÒÙ"), "AEIOU");
}

#[test]
fn test_ex2() {
    assert_eq!(any_ascii("âÊíÒÙ"), "aEiOU");
}
