#! /bin/sh
//usr/bin/env rustc $0 -o ${0}x && ./${0}x; rm -f ${0}x ; exit

fn main() {
    let chr="^";
    let shape: Vec<i8>=vec![3,-3,-4,-5,-5,-5,-5,-5,-4,-3,3,1,1,1,3,1,1];
    let mx: usize=shape.clone().into_iter().map(|i| i.abs()).max().unwrap() as usize;
    for row in shape {
        let mut line;
        if row>0 {
            line=(0..row).map(|_| chr).collect::<String>();
        } else {
            line=(0..-row).map(|_| " ").collect::<String>() + chr;
        }
        let ll=line.len();
        if ll <= mx {
            line += &(0..mx-ll+1).map(|_| " ").collect::<String>();
        }
        let f: String=line[1..].chars().rev().collect();
        println!("{}{}",f,line);
    }
}
