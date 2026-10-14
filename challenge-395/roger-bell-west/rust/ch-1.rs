use regex::Regex;

#[test]
fn test_ex1() {
    assert_eq!(complexnumber("1+1i", "1+1i"), "0+2i");
}

#[test]
fn test_ex2() {
    assert_eq!(complexnumber("1+(-1)i", "1+(-1)i"), "0+(-2)i");
}

#[test]
fn test_ex3() {
    assert_eq!(complexnumber("0+3i", "0+4i"), "-12+0i");
}

#[test]
fn test_ex4() {
    assert_eq!(complexnumber("3+4i", "3+(-4)i"), "25+0i");
}

#[test]
fn test_ex5() {
    assert_eq!(complexnumber("50+-20i", "-10+30i"), "100+1700i");
}

fn parsecomplex(a: &str) -> (i32, i32) {
    let re = Regex::new(r"^\(?([-0-9]+)\)?\+\(?([-0-9]+)\)?i$").unwrap();
    let mut c = Vec::new();
    if let Some(caps) = re.captures(a) {
        for n in 1..=2 {
            c.push(caps.get(n).unwrap().as_str().parse::<i32>().unwrap());
        }
        return (c[0], c[1]);
    }
    (0, 0)
}

fn complexnumber(aa: &str, bb: &str) -> String {
    let (a, b) = parsecomplex(aa);
    let (c, d) = parsecomplex(bb);
    let ca = a * c - b * d;
    let cb = a * d + b * c;
    if cb >= 0 {
        format!("{:}+{:}i", ca, cb)
    } else {
        format!("{:}+({:})i", ca, cb)
    }
}
