use counter::Counter;

#[test]
fn test_ex1() {
    assert_eq!(shufflepairs(1, 1000, 1), 0);
}

#[test]
fn test_ex2() {
    assert_eq!(shufflepairs(1500, 2500, 1), 3);
}

#[test]
fn test_ex3() {
    assert_eq!(shufflepairs(1000000, 1500000, 5), 2);
}

#[test]
fn test_ex4() {
    assert_eq!(shufflepairs(13427000, 14100000, 2), 11);
}

#[test]
fn test_ex5() {
    assert_eq!(shufflepairs(1000, 5000, 1), 7);
}

fn countdigits(a: u32) -> Counter<char> {
    a.to_string().chars().collect::<Counter<char>>()
}

fn shufflepairs(low: u32, high: u32, pairs: u32) -> usize {
    let mut total = 0;
    for candidate in low ..= high {
        let candidatec = countdigits(candidate);
        let mut cnt = 0;
        for mul in 2 .. 10 {
            let test = candidate * mul;
            let testc = countdigits(test);
            if testc == candidatec {
                cnt += 1;
                if cnt >= pairs {
                    break
                }
            }
        }
        if cnt >= pairs {
            total += 1;
        }
    }
    total
}
