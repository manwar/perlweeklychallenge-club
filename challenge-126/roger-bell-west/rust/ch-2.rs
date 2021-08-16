#! /bin/sh
//usr/bin/env rustc $0 -o ${0}x && ./${0}x; rm -f ${0}x ; exit

fn main() {
    let ina=vec![
        vec!['x','*','*','*','x','*','x','x','x','x'],
        vec!['*','*','*','*','*','*','*','*','*','x'],
        vec!['*','*','*','*','x','*','x','*','x','*'],
        vec!['*','*','*','x','x','*','*','*','*','*'],
        vec!['x','*','*','*','x','*','*','*','*','x']
    ];
    let ymax=ina.len()-1;
    let xmax=ina[0].len()-1;
    let mut mn: Vec<Vec<u8>>=vec![vec![0;xmax+1];ymax+1];
    for y in 0..=ymax {
        for x in 0..=xmax {
            if ina[y][x] == 'x' {
                let mut yl=0;
                if y>1 {
                    yl=y-1;
                }
                let mut yh=y+1;
                if yh>ymax {
                    yh=ymax;
                }
                for yi in yl ..= yh {
                    let mut xl=0;
                    if x>1 {
                        xl=x-1;
                    }
                    let mut xh=x+1;
                    if xh>xmax {
                        xh=xmax;
                    }
                    for xi in xl ..= xh {
                        if xi==x && yi==y {
                            continue;
                        }
                        mn[yi][xi] += 1;
                    }
                }
            }
        }
    }
    for y in 0..=ymax {
        let mut line: Vec<String>=vec![];
        for x in 0..=xmax {
            if ina[y][x] == 'x' {
                line.push("x".to_string());
            } else {
                line.push(mn[y][x].to_string());
            }
        }
        println!("{}",line.join(" "));
    }
}
