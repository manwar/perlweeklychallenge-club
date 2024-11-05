use itertools::Itertools;

#[test]
fn test_ex1() {
    assert_eq!(nextpermutation(vec![1, 2, 3]), vec![1, 3, 2]);
}

#[test]
fn test_ex2() {
    assert_eq!(nextpermutation(vec![2, 1, 3]), vec![2, 3, 1]);
}

#[test]
fn test_ex3() {
    assert_eq!(nextpermutation(vec![3, 1, 2]), vec![3, 2, 1]);
}

fn nextpermutation(a: Vec<u32>) -> Vec<u32> {
    let mut b = a.clone();
    b.sort();
    let mut flag = false;
    let mut out: Vec<u32> = Vec::new();
    for px in b.iter().permutations(b.len()) {
        let py = px.iter().copied().copied().collect::<Vec<u32>>();
        if out.len() == 0 {
            out = py.clone();
        }
        if flag {
            out = py.clone();
            break;
        }
        if py == a {
            flag = true;
        }
    }
    out
}
