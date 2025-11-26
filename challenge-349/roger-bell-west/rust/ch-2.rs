use counter::Counter;

#[test]
fn test_ex1() {
    assert_eq!(meetingpoint("ULD"), false);
}

#[test]
fn test_ex2() {
    assert_eq!(meetingpoint("ULDR"), true);
}

#[test]
fn test_ex3() {
    assert_eq!(meetingpoint("UUURRRDDD"), false);
}

#[test]
fn test_ex4() {
    assert_eq!(meetingpoint("UURRRDDLLL"), true);
}

#[test]
fn test_ex5() {
    assert_eq!(meetingpoint("RRUULLDDRRUU"), false);
}

fn meetingpoint(a: &str) -> bool {
    let c = a.chars().collect::<Counter<_>>();
    c[&'U'] == c[&'D'] && c[&'L'] == c[&'R']
}
