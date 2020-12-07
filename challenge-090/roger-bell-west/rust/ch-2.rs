#! /bin/sh
//usr/bin/env rustc $0 -o ${0}x && ./${0}x; rm -f ${0}x ; exit

fn em(aa: i32, bb: i32) {
    let mut a=aa;
    let mut b=bb;
    let mut s=0;
    let mut demo=Vec::<String>::new();
    while a > 0 {
        let mut line: String=format!("{:>5} {:>5}",a,b).to_string();
        if a & 1 == 1 {
            s += b;
            line.push_str(&format!(" -> {:>5}",b)[0..]);
        }
        a >>= 1;
        b <<= 1;
        demo.push(line);
    }
    demo.push("               -----".to_string());
    demo.push(format!("               {:>5}",s).to_string());
    for i in demo {
        println!("{}",i);
    }
}

fn main() {
    em(13,238);
}
