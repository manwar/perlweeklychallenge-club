use counter::Counter;

#[test]
fn test_ex1() {
    assert_eq!(oddcharacter("Perl", "Preel"), 'e');
}

#[test]
fn test_ex2() {
    assert_eq!(oddcharacter("Weekly", "Weeakly"), 'a');
}

#[test]
fn test_ex3() {
    assert_eq!(oddcharacter("Box", "Boxy"), 'y');
}

fn oddcharacter(s: &str, t: &str) -> char {
    let mut ss = s.chars().collect::<Counter<char>>();
    for c in t.chars() {
        if ss[&c] > 0 {
            ss[&c] -= 1;
        } else {
            return c;
        }
    }
    '@'
}
