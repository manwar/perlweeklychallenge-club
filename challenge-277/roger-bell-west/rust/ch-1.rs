use counter::Counter;

#[test]
fn test_ex1() {
    assert_eq!(
        countcommon(
            vec!["Perl", "is", "my", "friend"],
            vec!["Perl", "and", "Raku", "are", "friend"]
        ),
        2
    );
}

#[test]
fn test_ex2() {
    assert_eq!(
        countcommon(
            vec!["Perl", "and", "Python", "are", "very", "similar"],
            vec!["Python", "is", "top", "in", "guest", "languages"]
        ),
        1
    );
}

#[test]
fn test_ex3() {
    assert_eq!(
        countcommon(
            vec!["Perl", "is", "imperative", "Lisp", "is", "functional"],
            vec!["Crystal", "is", "similar", "to", "Ruby"]
        ),
        0
    );
}

fn countcommon(a: Vec<&str>, b: Vec<&str>) -> usize {
    let ac = a.into_iter().collect::<Counter<_>>();
    let bc = b.into_iter().collect::<Counter<_>>();
    let ch = ac.clone() | bc.clone();
    let cl = ac & bc;
    cl.keys().filter(|k| *ch.get(*k).unwrap() == 1).count()
}
