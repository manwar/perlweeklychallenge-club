#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(roman2int("I"), 1);
}

#[test]
fn test_ex2() {
    assert_eq!(roman2int("II"), 2);
}

#[test]
fn test_ex3() {
    assert_eq!(roman2int("IV"), 4);
}

#[test]
fn test_ex4() {
    assert_eq!(roman2int("IX"), 9);
}

#[test]
fn test_ex5() {
    assert_eq!(roman2int("XXX"), 30);
}

#[test]
fn test_ex6() {
    assert_eq!(roman2int("MDCLXVI"), 1666);
}

#[test]
fn test_ex7() {
    assert_eq!(int2roman(1), "I");
}

#[test]
fn test_ex8() {
    assert_eq!(int2roman(2), "II");
}

#[test]
fn test_ex9() {
    assert_eq!(int2roman(4), "IV");
}

#[test]
fn test_ex10() {
    assert_eq!(int2roman(9), "IX");
}

#[test]
fn test_ex11() {
    assert_eq!(int2roman(30), "XXX");
}

#[test]
fn test_ex12() {
    assert_eq!(int2roman(1666), "MDCLXVI");
}

#[test]
fn test_ex13() {
    assert_eq!(romanmaths("IV + V"), "IX");
}

#[test]
fn test_ex14() {
    assert_eq!(romanmaths("M - I"), "CMXCIX");
}

#[test]
fn test_ex15() {
    assert_eq!(romanmaths("X / II"), "V");
}

#[test]
fn test_ex16() {
    assert_eq!(romanmaths("XI * VI"), "LXVI");
}

#[test]
fn test_ex17() {
    assert_eq!(romanmaths("VII ** III"), "CCCXLIII");
}

#[test]
fn test_ex18() {
    assert_eq!(romanmaths("V - V"), "nulla");
}

#[test]
fn test_ex19() {
    assert_eq!(romanmaths("V / II"), "non potest");
}

#[test]
fn test_ex20() {
    assert_eq!(romanmaths("MMM + M"), "non potest");
}

#[test]
fn test_ex21() {
    assert_eq!(romanmaths("V - X"), "non potest");
}

// borrowed from https://rosettacode.org/wiki/Roman_numerals/Decode#Rust

struct RomanNumeral {
    symbol: &'static str,
    value: i32
}

const NUMERALS: [RomanNumeral; 13] = [
    RomanNumeral {symbol: "M",  value: 1000},
    RomanNumeral {symbol: "CM", value: 900},
    RomanNumeral {symbol: "D",  value: 500},
    RomanNumeral {symbol: "CD", value: 400},
    RomanNumeral {symbol: "C",  value: 100},
    RomanNumeral {symbol: "XC", value: 90},
    RomanNumeral {symbol: "L",  value: 50},
    RomanNumeral {symbol: "XL", value: 40},
    RomanNumeral {symbol: "X",  value: 10},
    RomanNumeral {symbol: "IX", value: 9},
    RomanNumeral {symbol: "V",  value: 5},
    RomanNumeral {symbol: "IV", value: 4},
    RomanNumeral {symbol: "I",  value: 1}
];


fn roman2int(roman: &str) -> i32 {
    match NUMERALS.iter().find(|num| roman.starts_with(num.symbol)) {
        Some(num) => num.value + roman2int(&roman[num.symbol.len()..]),
        None => 0, // if string empty, add nothing
    }
}

fn int2roman(mut number: i32) -> String {
    let mut min_numeral = String::new();
    for numeral in NUMERALS.iter() {
        while numeral.value <= number {
            min_numeral = min_numeral + numeral.symbol;
            number -= numeral.value;
        }
    }
    min_numeral
}

fn pow(x0: i32, pow0: i32) -> i32 {
    let mut x = x0;
    let mut pow = pow0;
    let mut ret = 1;
    while pow > 0 {
        if (pow & 1) == 1 {
            ret *= x;
        }
        x *= x;
        pow >>= 1;
    }
    ret
}

fn romanmaths(ax: &str) -> String {
    let elems = ax.split(' ').collect::<Vec<&str>>();
    let a = roman2int(elems[0]);
    let b = roman2int(elems[2]);
    let c = match elems[1] {
        "+" => a + b,
        "-" => a - b,
        "*" => a * b,
        "/" => if a % b == 0 { a / b } else { -1 },
        "**" => pow(a, b),
        _ => -1,
    };
    if c > 3999 || c < 0 {
        "non potest".to_string()
    } else if c == 0 {
        "nulla".to_string()
    } else {
        int2roman(c)
    }
}
