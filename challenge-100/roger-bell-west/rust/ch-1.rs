use regex::Regex;

// Cargo.toml needs:
// [dependencies]
// regex = "1"

#[test]
fn test_ex1() {
    assert_eq!(ft("05:15 pm"),"17:15");
}

#[test]
fn test_ex2() {
    assert_eq!(ft("05:15 pm"),"17:15");
}

#[test]
fn test_ex3() {
    assert_eq!(ft("19:15"),"07:15 pm");
}

#[test]
fn test_ex4() {
    assert_eq!(ft("00:00"),"12:00 am");
}

#[test]
fn test_ex5() {
    assert_eq!(ft("12:00"),"12:00 pm");
}

#[test]
fn test_ex6() {
    assert_eq!(ft("12:00 am"),"00:00");
}

#[test]
fn test_ex7() {
    assert_eq!(ft("12:00 pm"),"12:00");
}

fn ft(text: &str) -> String {
    let re: Regex=Regex::new(r"(\d+):(\d+)\s*([ap]m)?").unwrap();
    let caps=re.captures(text).unwrap();
    let mut h: i8=caps.get(1).unwrap().as_str().parse::<i8>().unwrap();
    let mut t: String="".to_string();
    let ampm=match caps.get(3) {
        None => "",
        Some(i) => i.as_str(),
    };
    if ampm.len()>0 {
        if h==12 {
            h=0;
        }
        if ampm == "pm" {
            h += 12;
        }
    } else {
        t=" am".to_string();
        if h>11 {
            t=" pm".to_string();
            h -= 12;
        }
        if h==0 {
            h=12
        }
    }
    return format!("{:02}:{:02}{}",h,caps.get(2).unwrap().as_str(),t);
}
