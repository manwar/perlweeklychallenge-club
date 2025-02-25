use counter::Counter;

#[test]
fn test_ex1() {
    assert_eq!(deleteandearn(vec![3, 4, 2]), 6);
}

#[test]
fn test_ex2() {
    assert_eq!(deleteandearn(vec![2, 2, 3, 3, 3, 4]), 9);
}

fn deleteandearn(a: Vec<u32>) -> u32 {
    let ct = a.into_iter().collect::<Counter<u32>>();
    let mut mx = 0;
    let mut stack = Vec::new();
    stack.push((ct, 0));
    while let Some(c) = stack.pop() {
        if c.0.len() == 0 {
            mx = std::cmp::max(mx, c.1);
        } else {
            for d in c.0.keys() {
                let mut cc = c.0.clone();
                cc[&d] -= 1;
                if cc[&d] == 0 {
                    cc.remove(&d);
                }
                cc.remove(&(d-1));
                cc.remove(&(d+1));
                stack.push((cc, c.1 + d));
            }
        }
    }
    mx
}
