#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x; rm -f ${0}x ; exit

use std::io::Read;
use std::str;
use std::borrow::Borrow;

#[test]
fn test_ex1() {
    let mut r=Reader::new("input.txt");
    assert_eq!(r.readN(4),"1234");
    assert_eq!(r.readN(4),"5678");
    assert_eq!(r.readN(4),"90");
}

pub struct Reader {
    handle: std::fs::File
}

impl Reader {

    pub fn new(fname: &str) -> Reader {
        let fna=fname.to_string();
        let fh=std::fs::File::open(fna).unwrap();
        Reader { handle: fh }
    }

#[allow(non_snake_case)]

    pub fn readN(&mut self, siz: usize) -> String {
        let mut buf=vec![0u8; siz];
        let mut taker=self.handle.borrow().take(siz as u64);
        let t=taker.read(&mut buf).unwrap();
        let q=&buf[0..t];
        let s=str::from_utf8(&q).unwrap();
        return s.to_string();
    }
}
