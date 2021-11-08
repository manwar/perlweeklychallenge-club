use regex::Regex;

#[test]
fn test_ex1() {
    assert_eq!(ca("03:10"),35.0);
}

#[test]
fn test_ex2() {
    assert_eq!(ca("04:00"),120.0);
}

fn ca (n: &str) -> f32 {
    let mut a;
    let p = Regex::new(r"([0-9]+):([0-9]+)").unwrap();
    let m=p.captures(&n).unwrap();
    let hh=m.get(1).unwrap().as_str().parse::<f32>().unwrap();
    let mm=m.get(2).unwrap().as_str().parse::<f32>().unwrap();
    let ha=hh*30.+mm/2.;
    let ma=mm*6.;
    a=(ha-ma).abs();
    while a > 180. {
        a -= 180.;
    }
    a=a.abs();
    return a;
}
