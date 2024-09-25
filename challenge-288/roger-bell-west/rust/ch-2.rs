#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

use std::collections::{HashSet, VecDeque};

#[test]
fn test_ex1() {
    assert_eq!(
        contiguousblock(vec![
            vec!['x', 'x', 'x', 'x', 'o'],
            vec!['x', 'o', 'o', 'o', 'o'],
            vec!['x', 'o', 'o', 'o', 'o'],
            vec!['x', 'x', 'x', 'o', 'o']
        ]),
        11
    );
}

#[test]
fn test_ex2() {
    assert_eq!(
        contiguousblock(vec![
            vec!['x', 'x', 'x', 'x', 'x'],
            vec!['x', 'o', 'o', 'o', 'o'],
            vec!['x', 'x', 'x', 'x', 'o'],
            vec!['x', 'o', 'o', 'o', 'o']
        ]),
        11
    );
}

#[test]
fn test_ex3() {
    assert_eq!(
        contiguousblock(vec![
            vec!['x', 'x', 'x', 'o', 'o'],
            vec!['o', 'o', 'o', 'x', 'x'],
            vec!['o', 'x', 'x', 'o', 'o'],
            vec!['o', 'o', 'o', 'x', 'x']
        ]),
        7
    );
}

fn contiguousblock(a: Vec<Vec<char>>) -> usize {
    let y = a.len() as isize;
    let x = a[0].len() as isize;
    let mut starts: HashSet<(isize, isize)> = HashSet::new();
    for cx in 0..x {
        for cy in 0..y {
            starts.insert((cx, cy));
        }
    }
    let mut maxblock = 0;
    while starts.len() > 0 {
        let start = starts.iter().nth(0).unwrap();
        let mut queue: VecDeque<(isize, isize)> = VecDeque::new();
        let mut visited: HashSet<(isize, isize)> = HashSet::new();
        visited.insert(*start);
        queue.push_back(*start);
        while let Some(here) = queue.pop_front() {
            for delta in [(-1, 0), (1, 0), (0, -1), (0, 1)].iter() {
                if (delta.0 >= 0 || here.0 > 0)
                    && (delta.0 <= 0 || here.0 < x - 1)
                    && (delta.1 >= 0 || here.1 > 0)
                    && (delta.1 <= 0 || here.1 < y - 1)
                {
                    let there = (here.0 + delta.0, here.1 + delta.1);
                    if !visited.contains(&there)
                        && a[there.1 as usize][there.0 as usize]
                            == a[start.1 as usize][start.0 as usize]
                    {
                        visited.insert(there);
                        queue.push_back(there);
                    }
                }
            }
        }
        let size = visited.len();
        if size > maxblock {
            maxblock = size;
        }
        starts = starts.difference(&visited).copied().collect::<HashSet<_>>();
    }
    maxblock
}
