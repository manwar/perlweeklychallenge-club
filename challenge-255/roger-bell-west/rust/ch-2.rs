use counter::Counter;

#[test]
fn test_ex1() {
    assert_eq!(
        mostfrequentword(
            "Joe hit a ball, the hit ball flew far after it was hit.",
            "hit"
        ),
        "ball"
    );
}

#[test]
fn test_ex2() {
    assert_eq!(mostfrequentword("Perl and Raku belong to the same family. Perl is the most popular language in the weekly challenge.", "the"), "Perl");
}

fn mostfrequentword(para: &str, banned: &str) -> String {
    let mut words = para
        .split(|c: char| !c.is_alphabetic())
        .filter(|s| s.len() > 0)
        .collect::<Counter<&str>>();
    words.remove(&banned);
    words.k_most_common_ordered(1)[0].0.to_string()
}
