use itertools::Itertools;

#[test]
fn test_ex1() {
    assert_eq!(makingchange(9), 2);
}

#[test]
fn test_ex2() {
    assert_eq!(makingchange(15), 6);
}

#[test]
fn test_ex3() {
    assert_eq!(makingchange(100), 292);
}

fn makingchange(a: u32) -> usize {
    let coins = vec![1, 5, 10, 25, 50];
    let max = coins.clone().into_iter().map(|x| a / x).collect::<Vec<_>>();
    let mut pat = Vec::new();
    for i in 0 .. coins.len() {
        if max[i] > 0 {
            pat.push((0 ..= max[i]).collect::<Vec<_>>());
        } else {
             break;
        }
    }
    let mut ct = 0;
    for combo in pat.iter().multi_cartesian_product() {
        let mut t = 0;
        for (i, c) in combo.iter().enumerate() {
            t += *c * coins[i];
            if t > a {
                break;
            }
        }
        if t == a {
            ct += 1;
        }
    }
    ct
}

