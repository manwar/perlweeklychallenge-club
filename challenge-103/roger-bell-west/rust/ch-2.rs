// Cargo.toml needs:
// [dependencies]
// csv = "1.1"

use std::fs::File;

#[test]
fn test_ex1() {
    assert_eq!(wp(1606134123,1614591276,"t2.csv"),"00:10:24 Les Miserables Episode 1: The Bishop (broadcast date: 1937-07-23)");
}

pub struct Track {
    length: i64,
    title: String
}

fn wp (ts: i64,tn: i64,csvfile: &str) -> String {
    let mut td: i64=(tn-ts)*1000;
    let file=File::open(&csvfile).unwrap();
    let mut rdr = csv::ReaderBuilder::new()
        .has_headers(false)
        .from_reader(file);
    let mut aoa: Vec<Track>=vec![];
    for result in rdr.records() {
        let record = result.unwrap();
        aoa.push(Track {
            length: record.get(0).unwrap().parse::<i64>().unwrap(),
            title: record.get(1).unwrap().to_string()
        });
    }
    let tp: i64=aoa.iter()
        .map(|t| t.length)
        .sum();
    td %= tp;
    for t in aoa {
        if td < t.length {
            td=td/1000;
            let h=td/3600;
            let m=(td/60) % 60;
            let s=td % 60;
            return format!("{:02}:{:02}:{:02} {}",h,m,s,t.title);
        } else {
            td -= t.length;
        }
    }
    return "".to_string();
}
