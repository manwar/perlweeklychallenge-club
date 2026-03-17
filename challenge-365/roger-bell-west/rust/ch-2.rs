use regex::Regex;

#[test]
fn test_ex1() {
    assert_eq!(validtokencounter("cat and dog"), 3);
}

#[test]
fn test_ex2() {
    assert_eq!(validtokencounter("a-b c! d,e"), 2);
}

#[test]
fn test_ex3() {
    assert_eq!(validtokencounter("hello-world! this is fun"), 4);
}

#[test]
fn test_ex4() {
    assert_eq!(validtokencounter("ab- cd-ef gh- ij!"), 2);
}

#[test]
fn test_ex5() {
    assert_eq!(validtokencounter("wow! a-b-c nice."), 2);
}

fn validtokencounter(a: &str) -> usize {
    let mut count = 0;
    for k in a.split(' ') {
        // "contains no digits"
        if Regex::new("[0-9]").unwrap().is_match(&k) {
            continue;
        }
        // "has at most one hyphen surrounded by lowercase letters"
        // multiple hyphens
        if Regex::new("-.*-").unwrap().is_match(&k) {
            continue;
        }
        // if hyphen, must be surrounded by letters
        if Regex::new("-").unwrap().is_match(&k) &&
            !Regex::new("[a-z]-[a-z]").unwrap().is_match(&k) {
                continue;
            }
        // "at most one punctuation mark (!, ., ,) appearing only at the end."
        if Regex::new("[.,!].").unwrap().is_match(&k) {
            continue;
        }
        count += 1;
    }
    count
}
