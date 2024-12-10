#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

use std::collections::HashMap;

#[test]
fn test_ex1() {
    assert_eq!(
        wordsearch(
            vec![
                vec!['A', 'B', 'D', 'E'],
                vec!['C', 'B', 'C', 'A'],
                vec!['B', 'A', 'A', 'D'],
                vec!['D', 'B', 'B', 'C']
            ],
            "BDCA"
        ),
        true
    );
}

#[test]
fn test_ex2() {
    assert_eq!(
        wordsearch(
            vec![
                vec!['A', 'A', 'B', 'B'],
                vec!['C', 'C', 'B', 'A'],
                vec!['C', 'A', 'A', 'A'],
                vec!['B', 'B', 'B', 'B']
            ],
            "ABAC"
        ),
        false
    );
}

#[test]
fn test_ex3() {
    assert_eq!(
        wordsearch(
            vec![
                vec!['B', 'A', 'B', 'A'],
                vec!['C', 'C', 'C', 'C'],
                vec!['A', 'B', 'A', 'B'],
                vec!['B', 'B', 'A', 'A']
            ],
            "CCCAA"
        ),
        true
    );
}

fn wordsearch(grid0: Vec<Vec<char>>, word0: &str) -> bool {
    let mut grid: HashMap<(isize, isize), char> = HashMap::new();
    for (y, row) in grid0.iter().enumerate() {
        for (x, c) in row.iter().enumerate() {
            grid.insert((x as isize, y as isize), *c);
        }
    }
    let word = word0.chars().collect::<Vec<char>>();
    for (start, firstletter) in grid.iter() {
        if *firstletter == word[0] {
            let mut queue: Vec<Vec<(isize, isize)>> = Vec::new();
            queue.push(vec![*start]);
            while let Some(pos) = queue.pop() {
                if pos.len() == word.len() {
                    return true;
                } else {
                    for dir in [(0, 1), (1, 0), (0, -1), (-1, 0)] {
                        let lpos = pos.last().unwrap();
                        let npos = (lpos.0 + dir.0, lpos.1 + dir.1);
                        if grid.contains_key(&npos)
                            && !pos.contains(&npos)
                            && *grid.get(&npos).unwrap() == word[pos.len()]
                        {
                            let mut pp = pos.clone();
                            pp.push(npos);
                            queue.push(pp);
                        }
                    }
                }
            }
        }
    }
    false
}
