fn main() {
    let c = vec![1, 2, 4];
    let s = 6;

    let o: Vec<Vec<u32>> = doit(&c, s);

    assert_eq!(o, vec![
        vec![1, 1, 1, 1, 1, 1],
        vec![1, 1, 1, 1, 2],
        vec![1, 1, 2, 2],
        vec![1, 1, 4],
        vec![2, 2, 2],
        vec![2, 4],
    ]);
}

fn doit(c: &[u32], s: u32) -> Vec<Vec<u32>> {
    println!("C = {:?}", c);
    println!("S = {}", s);
    let o = doit_inner(c, s);
    println!("There are {} possible ways to make sum {}.", o.len(), s);
    println!("{:#?}", o);
    o
}

fn doit_inner(c: &[u32], s: u32) -> Vec<Vec<u32>> {
    if s == 0 {
        return vec![vec![]];
    }
    let first_coin = c[0];
    let rest = &c[1..];
    (0..=s / first_coin).rev().flat_map(|num| {
        let first_coin_sum = first_coin * num;
        if rest.len() == 0 {
            // last coin, must have exact match
            return if first_coin_sum == s {
                vec![vec![first_coin; num as usize]]
            } else {
                vec![]
            };
        }
        let mut rest = doit_inner(rest, s - first_coin_sum);
        rest.iter_mut()
            .map(|sub| {
                let mut v = vec![first_coin; num as usize];
                v.append(sub);
                v
            })
            .collect::<Vec<Vec<u32>>>()
    }).collect()
}
