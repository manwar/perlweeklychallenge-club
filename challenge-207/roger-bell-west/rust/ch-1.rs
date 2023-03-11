// [dependencies]
// regex = "1"

use regex::Regex;

#[test]
fn test_ex1() {
    assert_eq!(
        keyboardword(vec!["Hello", "Alaska", "Dad", "Peace"]),
        vec!["Alaska", "Dad"]
    );
}

#[test]
fn test_ex2() {
    assert_eq!(keyboardword(vec!["OMG", "Bye"]), Vec::<String>::new());
}

fn keyboardword(wl: Vec<&str>) -> Vec<String> {
    let re =
        Regex::new(r"(?i)^([qwertyuiop]+|[asdfghjkl]+|[zxcvbnm]+)$").unwrap();
    wl.into_iter()
        .filter(|w| re.is_match(w))
        .map(|w| w.to_string())
        .collect::<Vec<String>>()
}
