use itertools::Itertools;

#[test]
fn test_ex1() {
    assert_eq!(shortesttime(vec!["00:00", "23:55", "20:00"]), 5);
}

#[test]
fn test_ex2() {
    assert_eq!(shortesttime(vec!["01:01", "00:50", "00:57"]), 4);
}

#[test]
fn test_ex3() {
    assert_eq!(shortesttime(vec!["10:10", "09:30", "09:00", "09:55"]), 15);
}

fn shortesttime(n: Vec<&str>) -> isize {
    let dl = 1440;
    let mut ni = Vec::new();
    for x in n {
        ni.push(
            x[0..=1].parse::<isize>().unwrap() * 60
                + x[3..=4].parse::<isize>().unwrap(),
        );
    }
    let mut o = Vec::new();
    for p in ni.iter().combinations(2) {
        let d = (p[0] - p[1]).abs();
        o.push(d);
        o.push(dl - d);
    }
    *o.iter().min().unwrap()
}
