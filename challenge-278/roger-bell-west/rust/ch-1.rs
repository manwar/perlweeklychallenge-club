use regex::Regex;

#[test]
fn test_ex1() {
    assert_eq!(
        sortstring("and2 Raku3 cousins5 Perl1 are4"),
        "Perl and Raku are cousins"
    );
}

#[test]
fn test_ex2() {
    assert_eq!(
        sortstring("guest6 Python1 most4 the3 popular5 is2 language7"),
        "Python is the most popular guest language"
    );
}

#[test]
fn test_ex3() {
    assert_eq!(sortstring("Challenge3 The1 Weekly2"), "The Weekly Challenge");
}

fn sortstring(a: &str) -> String {
    let words = a.split(' ').collect::<Vec<&str>>();
    let mut out = vec![String::new(); words.len()];
    let re = Regex::new(r"^(.*?)([0-9]+)$").unwrap();
    for w in words {
        let c = re.captures(&w).unwrap();
        let index = c.get(2).unwrap().as_str().parse::<usize>().unwrap() - 1;
        out[index] = c.get(1).unwrap().as_str().to_string();
    }
    out.join(" ")
}
