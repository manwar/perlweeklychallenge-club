#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x; rm -f ${0}x ; exit

use std::collections::HashMap;

#[test]
fn test_ex1() {
    let mut fc=Fusc::new();
    assert_eq!(fc.fuscseq(50),vec![0, 1, 1, 2, 1, 3, 2, 3, 1, 4, 3, 5, 2, 5, 3, 4, 1, 5, 4, 7, 3, 8, 5, 7, 2, 7, 5, 8, 3, 7, 4, 5, 1, 6, 5, 9, 4, 11, 7, 10, 3, 11, 8, 13, 5, 12, 7, 9, 2, 9]);
}

pub struct Fusc {
    cache: HashMap<u32,u32>
}

impl Fusc {

    pub fn new() -> Fusc {
        Fusc {
            cache: HashMap::new()
        }
    }
    
    pub fn fuscseq(&mut self,m: u32) -> Vec<u32> {
        return (0..m).map(|i| self.fusc(i)).collect::<Vec<u32>>();
    }

    pub fn fusc(&mut self,n: u32) -> u32 {
        if self.cache.contains_key(&n) {
            return *self.cache.get(&n).unwrap();
        }
        let m: u32;
        if n==0 {
            m=0;
        } else if n==1 {
            m=1;
        } else if n%2 == 0 {
            m=self.fusc(n/2)
        } else {
            let h: u32=(n-1)/2;
            m=self.fusc(h)+self.fusc(h+1);
        }
        self.cache.insert(n,m);
        return m;
    }
}
