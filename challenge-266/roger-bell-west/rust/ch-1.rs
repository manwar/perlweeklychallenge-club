use counter::Counter;
use std::collections::HashSet;

#[test]
fn test_ex1() {
    assert_eq!(
        uncommonwords("Mango is sweet", "Mango is sour"),
        vec!["sweet", "sour"]
    );
}

#[test]
fn test_ex2() {
    assert_eq!(uncommonwords("Mango Mango", "Orange"), vec!["Orange"]);
}

#[test]
fn test_ex3() {
    assert_eq!(
        uncommonwords("Mango is Mango", "Orange is Orange"),
        Vec::<String>::new()
    );
}

fn getlistset(a: &str) -> (Vec<&str>, HashSet<&str>) {
    let mut la = a.split(' ').collect::<Vec<&str>>();
    let ca = la.iter().copied().collect::<Counter<&str>>();
    la.retain(|k| *ca.get(k).unwrap() == 1);
    (la, ca.keys().copied().collect::<HashSet<&str>>())
}

fn uncommonwords(a: &str, b: &str) -> Vec<String> {
    let (la, sa) = getlistset(a);
    let (lb, sb) = getlistset(b);
    let mut out = Vec::new();
    for (&ref wl, &ref t) in [(&la, &sb), (&lb, &sa)] {
        for w in wl {
            if !t.contains(w) {
                out.push(w.to_string());
            }
        }
    }
    out
}
