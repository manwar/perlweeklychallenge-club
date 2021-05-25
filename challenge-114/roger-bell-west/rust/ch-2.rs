use regex::Regex;

#[test]
fn test_ex1() {
    assert_eq!(hisb(3),5);
}

#[test]
fn test_ex2() {
    assert_eq!(hisb(12),17);
}

fn hisb (n: u64) -> u64 {
    let mut s="0".to_string();
    s.push_str(&format!("{:b}",n));
    let p = Regex::new(r"^(.*?)01(1*0*)$").unwrap();
    let m=p.captures(&s).unwrap();
    let a=m.get(1).unwrap().as_str();
    let c=m.get(2).unwrap().as_str();
    let t0=c.replace("1","");
    let t1=c.replace("0","");
    let mut bs=a.to_string();
    bs.push_str("10");
    bs.push_str(&t0);
    bs.push_str(&t1);
    return u64::from_str_radix(&bs,2).unwrap();
}
