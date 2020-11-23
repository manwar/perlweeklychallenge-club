#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x; rm -f ${0}x ; exit

use std::convert::TryInto;

#[test]
fn test_ex1() {
    assert_eq!(sm(vec![
  vec![ 1, 2, 3 ],
  vec![ 4, 5, 6 ],
  vec![ 7, 8, 9 ]
    ]),vec![1, 2, 3, 6, 9, 8, 7, 4, 5]);
}

#[test]
fn test_ex2() {
    assert_eq!(sm(vec![
  vec![  1,  2,  3,  4 ],
  vec![  5,  6,  7,  8 ],
  vec![  9, 10, 11, 12 ],
  vec![ 13, 14, 15, 16 ],
    ],),vec![1, 2, 3, 4, 8, 12, 16, 15, 14, 13, 9, 5, 6, 7, 11, 10]);
}

fn sm(m: Vec<Vec<i32>>) -> Vec<i32> {
    let mx=m.len() as usize;
    let my: usize=m[0].len();
    let mut o=Vec::<i32>::with_capacity((mx*my).try_into().unwrap());
    o.push(m[0][0]);
    let mut v=vec![vec![false; my]; mx];
    let dir=vec![
        vec![0,1],
        vec![1,0],
        vec![0,-1],
        vec![-1,0]
    ];
    let mut x :usize=0;
    let mut y :usize=0;
    let mut d :usize=0;
    for _i in 1..mx*my {
        v[x][y]=true;
        let mut nx: isize;
        let mut ny: isize;
        loop {
            nx=(x as isize)+dir[d][0];
            ny=(y as isize)+dir[d][1];
            let mut ex=false;
            if nx < 0 || nx as usize >= mx ||
                ny < 0 || ny as usize >= my {
                    ex=true;
                }
            if ex==false {
                if v[nx as usize][ny as usize]==true {
                    ex=true;
                }
            }
            if ex {
                d=(d+1)%4;
            } else {
                break;
            }
        }
        x=nx.try_into().unwrap();
        y=ny.try_into().unwrap();
        o.push(m[x][y]);
    }
    return o
}

//sub sm(@m) {
//  my $mx=@m.elems;
//  my $my=@m[0].elems;
//  my @o=(@m[0][0]);
//  my @v;
//  for 1..$mx {
//    push @v,[(0) xx $my];
//  }
//  my @dir=(
//    [0,1],
//    [1,0],
//    [0,-1],
//    [-1,0],
//      );
//  my ($x,$y,$d)=(0,0,0);
//  for 2..$mx*$my {
//    @v[$x][$y]=1;
//    my ($nx,$ny);
//    while (1) {
//      ($nx,$ny)=($x+@dir[$d][0],$y+@dir[$d][1]);
//      if ($nx < 0 || $nx >= $mx || $ny < 0 || $ny >= $my || @v[$nx][$ny]==1) {
//        $d++;
//        $d%=4;
//      } else {
//        last;
//      }
//    }
//    ($x,$y)=($nx,$ny);
//    push @o,@m[$x][$y];
//  }
//  return @o.List;
//}
