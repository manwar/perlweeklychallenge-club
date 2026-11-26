#[test]
fn test_ex1() {
    assert_eq!(reconstructdigits("zroezerotwowtwotwo"), "00222");
}

#[test]
fn test_ex2() {
    assert_eq!(reconstructdigits("esveeneinght"), "78");
}

#[test]
fn test_ex3() {
    assert_eq!(reconstructdigits("oneenineeninefive"), "1599");
}

#[test]
fn test_ex4() {
    assert_eq!(reconstructdigits("zeroonetwothreeeightfivesixsevenninefour"), "0123456789");
}

#[test]
fn test_ex5() {
    assert_eq!(reconstructdigits("ninenineninenine"), "9999");
}

use counter::Counter;

fn reconstructdigits(a: &str) -> String {
    let digits = vec![
        "zero",
        "one",
        "two",
        "three",
        "four",
        "five",
        "six",
        "seven",
        "eight",
        "nine"
    ];
    let mut cc: Vec<Counter<char>> = Vec::new();
    for d in 0 ..= 9 {
        cc.push(digits[d].chars().collect::<Counter<_>>());
    }
    let mut cs = a.chars().collect::<Counter<_>>();
    let mut ol = Vec::new();
    for d in [2, 6, 0, 7, 4, 3, 5, 8, 1, 9] {
        while cc[d].is_subset(&cs) {
            ol.push(d);
            cs -= cc[d].clone();
        }
    }
    ol.sort();
    ol.into_iter().map(|x| char::from_u32(48 + x as u32).unwrap()).collect()
}
