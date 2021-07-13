use std::collections::HashMap;
use permutator::{Permutation,Combination};
use rand::prelude::*;
use std::time::Instant;

#[test]
fn test_ex1() {
    assert_eq!(tsp(vec![
        vec![0, 2, 9, 10],
        vec![1, 0, 6, 4],
        vec![15, 7, 0, 8],
        vec![6, 3, 12, 0]
    ]),(21,vec![0,2,3,1,0]));
}

#[test]
fn test_ex2() {
    assert_eq!(tsp(vec![
        vec![0, 5, 2, 7],
        vec![5, 0, 5, 3],
        vec![3, 1, 0, 6],
        vec![4, 5, 4, 0],
    ]),(10,vec![0,2,1,3,0]));
}

fn main() {
    for size in 4..=11 {
        let m=genmatrix(size);
        let start=Instant::now();
        let _o=tsp(m);
        let duration=start.elapsed();
        println!("| {} | {:?} |",size,duration);
    }
}

fn genmatrix(n: usize) -> Vec<Vec<usize>> {
    let mut m=vec![vec![0;n];n];
    for x in 0..n {
        for y in 0..n {
            if x != y {
                m[x][y]=thread_rng().gen::<u16>() as usize;
            }
        }
    }
    return m;
}

fn tsp (d: Vec<Vec<usize>>) -> (usize, Vec<usize>) {
    let n=d.len();
    let mut c: HashMap<(usize,usize),(usize,usize)>=HashMap::new();
    for k in 1..n {
        c.insert((1<<k,k),(d[0][k],0));
    }
    for ss in 2..n {
        let sb=(1..n).collect::<Vec<usize>>();
        sb.combination(ss).for_each(|mut sbb| {
            sbb.permutation().for_each(|s| {
                let mut bits: usize=0;
                s.iter().for_each(|bit| {bits += 1<<**bit});
                for k in &s {
                    let prev=bits & !(1<<**k);
                    let mut res: Vec<(usize,usize)>=vec![];
                    for m in &s {
                        if **m==0 || **m==**k {
                            continue;
                        }
                        res.push((c.get(&(prev,**m)).unwrap().0+d[**m][**k],**m));
                    }
                    c.insert((bits,**k),*res.iter().min().unwrap());
                }
            });
        });
    }
    let mut bitmask=(1<<n)-1 & !1;
    let opp=(1..n).collect::<Vec<usize>>().iter().map(|k| (c.get(&(bitmask,*k)).unwrap().0+d[*k][0],*k)).min().unwrap();
    let opt=opp.0;
    let mut parent=opp.1;
    let mut path: Vec<usize>=vec![];
    for _i in 0..n-1 {
        path.push(parent);
        let nb=bitmask & !(1 << parent);
        parent=c.get(&(bitmask,parent)).unwrap().1;
        bitmask=nb;
    }
    path.push(0);
    path.reverse();
    path.push(0);
    return (opt,path);
}
