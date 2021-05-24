use regex::Regex;

#[test]
fn test_ex1() {
    assert_eq!(ri(25,7),0);
}

#[test]
fn test_ex2() {
    assert_eq!(ri(24,7),1);
}

fn ri(n: u64,d:u64) -> u8 {
    let dd=Regex::new(&d.to_string()).unwrap();
    let e=(1..=n).filter(|i| dd.is_match(&i.to_string())).collect::<Vec<u64>>();
    for i in 1..1<<e.len() {
        let mut s=0;
        for ii in 0..e.len() {
            if (1 << ii & i) > 0 {
                s += e[ii]
            }
        }
        if s==n {
            return 1;
        }
    }
    return 0;
}
