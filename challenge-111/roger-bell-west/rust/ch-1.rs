#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(sm(vec![
        vec![1,2,3,5,7],
        vec![9,11,15,19,20],
        vec![23,24,25,29,31],
        vec![32,33,39,40,42],
        vec![45,47,48,49,50]
    ],35),0);
}

#[test]
fn test_ex2() {
    assert_eq!(sm(vec![
        vec![1,2,3,5,7],
        vec![9,11,15,19,20],
        vec![23,24,25,29,31],
        vec![32,33,39,40,42],
        vec![45,47,48,49,50]
    ],39),1);
}

fn sm(matrix: Vec<Vec<u64>>,search: u64) -> u8 {
    let mut f=0;
    for row in matrix {
        if row[0] <= search {
            if row[row.len()-1] >= search {
                if row.contains(&search) {
                    f=1;
                }
                break;
            }
        } else {
            break;
        }
    }
    return f;
}
