use regex::Regex;

#[test]
fn test_ex1() {
    assert_eq!(validnumber("1"), true);
}

#[test]
fn test_ex2() {
    assert_eq!(validnumber("a"), false);
}

#[test]
fn test_ex3() {
    assert_eq!(validnumber("."), false);
}

#[test]
fn test_ex4() {
    assert_eq!(validnumber("1.2e4.2"), false);
}

#[test]
fn test_ex5() {
    assert_eq!(validnumber("-1."), true);
}

#[test]
fn test_ex6() {
    assert_eq!(validnumber("+1E-8"), true);
}

#[test]
fn test_ex7() {
    assert_eq!(validnumber(".44"), true);
}

fn validnumber(a: &str) -> bool {
    let integer = r"[-+]?[0-9]+";
    let float = r"[-+]?([0-9]+\.[0-9]*|[0-9]*\.[0-9]+)";
    let exponential =
        "(".to_owned() + integer + "|" + float + ")[Ee]" + integer;
    let number =
        "^(".to_owned() + integer + "|" + float + "|" + &exponential + ")$";
    let rx = Regex::new(&number).unwrap();
    rx.is_match(a)
}
