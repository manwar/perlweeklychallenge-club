use chrono::{Utc, TimeZone, Datelike};

// [dependencies]
// chrono = "0.4.19"

#[test]
fn test_ex1() {
    assert_eq!(mirdat((2021,9,18),(2021,9,22)),vec![(2021,9,14),(2021,9,26)]);
}

#[test]
fn test_ex2() {
    assert_eq!(mirdat((1975,10,10),(2021,9,22)),vec![(1929,10,27),(2067,9,5)]);
}

#[test]
fn test_ex3() {
    assert_eq!(mirdat((1967,2,14),(2021,9,22)),vec![(1912,7,8),(2076,4,30)]);
}

fn mirdat(thn: (i32,u32,u32), now: (i32,u32,u32)) -> Vec<(i32,u32,u32)> {
    let thnt=Utc.ymd(thn.0,thn.1,thn.2);
    let nowt;
    if now.0==0 {
        nowt=Utc::today();
    } else {
        nowt=Utc.ymd(now.0,now.1,now.2);
    }
    let delta=nowt-thnt;
    let mut o: Vec<(i32,u32,u32)>=vec![];
    for targett in [thnt-delta,nowt+delta].iter() {
        o.push((targett.year(),targett.month(),targett.day()));
    }
    return o;
}
