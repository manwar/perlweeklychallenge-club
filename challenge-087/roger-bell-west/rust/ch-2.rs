#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
  assert_eq!(lr(vec![
        vec![0,0,0,1,0,0],
        vec![1,1,1,0,0,0],
        vec![0,0,1,0,0,1],
        vec![1,1,1,1,1,0],
        vec![1,1,1,1,1,0]
                 ]),
             vec![
        vec![1,1,1,1,1],
        vec![1,1,1,1,1]
             ]);
}

#[test]
fn test_ex2() {
  assert_eq!(lr(vec![
        vec![1,0,1,0,1,0],
        vec![0,1,0,1,0,1],
        vec![1,0,1,0,1,0],
        vec![0,1,0,1,0,1]
                 ]),
             vec![
        vec![1]
             ]);
}

#[test]
fn test_ex3() {
  assert_eq!(lr(vec![
        vec![0,0,0,1,1,1],
        vec![1,1,1,1,1,1],
        vec![0,0,1,0,0,1],
        vec![0,0,1,1,1,1],
        vec![0,0,1,1,1,1]
                 ]),
             vec![
        vec![1,1,1,1],
        vec![1,1,1,1],
             ]);
}

fn lr(s: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
    let maxx=s.len()-1;
    let maxy=s[0].len()-1;
    let mut maxa: i32 = 0;
    let mut c=[1,1];
    for x in 0..maxx {
        for y in 0..maxy {
            if s[x][y]==1 {
                for tx in x+1..maxx+1 {
                    for ty in y+1..maxy+1 {
                        let mut valid: bool = true;
                        for sx in x..tx+1 {
                            for sy in y..ty+1 {
                                if s[sx][sy] != 1 {
                                    valid=false;
                                    break;
                                }
                            }
                            if valid==false {
                                break;
                            }
                        }
                        if valid {
                            let l=[tx-x+1,ty-y+1];
                            let a=(l[0]*l[1]) as i32;
                            if a > maxa {
                                maxa=a;
                                c=l;
                            }
                        }
                    }
                }
            }
        }
    }
    return vec![vec![1; c[1]]; c[0]];
}
