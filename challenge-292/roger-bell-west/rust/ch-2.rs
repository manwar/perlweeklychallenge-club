use counter::Counter;
use std::collections::VecDeque;

#[test]
fn test_ex1() {
    assert_eq!(zumagame("WRRBBW", "RB"), -1);
}

#[test]
fn test_ex2() {
    assert_eq!(zumagame("WWRRBBWW", "WRBRW"), 2);
}

#[test]
fn test_ex3() {
    assert_eq!(zumagame("G", "GGGGG"), 2);
}

#[derive(Debug)]
struct Gamestate {
    row: Vec<char>,
    hand: Counter<char>,
    moves: u32,
}

fn zumagame(srow: &str, shand: &str) -> isize {
    let irow = srow.chars().collect::<Vec<char>>();
    let ihand = shand.chars().collect::<Counter<char>>();
    let mut queue: VecDeque<Gamestate> = VecDeque::new();
    queue.push_back(Gamestate { row: irow, hand: ihand, moves: 0 });
    let mut minball = None;
    while let Some(state) = queue.pop_front() {
        if state.row.len() == 0 {
            if minball.is_none() || minball.unwrap() > state.moves {
                minball = Some(state.moves);
            }
        } else if state.hand.len() > 0 {
            let mov = state.moves + 1;
            for loc in 0..state.row.len() {
                let bal = state.row[loc];
                if state.hand.contains_key(&bal) {
                    let mut row = state.row.clone();
                    let mut han = state.hand.clone();
                    han[&bal] -= 1;
                    if han[&bal] == 0 {
                        han.remove(&bal);
                    }
                    row.insert(loc, bal);
                    loop {
                        let mut changed = false;
                        let mut start = 0;
                        let mut c = row[0];
                        for i in 1..=row.len() {
                            if i == row.len() || row[i] != c {
                                if i - start > 2 {
                                    row.splice(start..i, []);
                                    changed = true;
                                    break;
                                }
                                if i != row.len() {
                                    start = i;
                                    c = row[i];
                                }
                            }
                        }
                        if row.len() == 0 || !changed {
                            break;
                        }
                    }
                    queue.push_back(Gamestate { row, hand: han, moves: mov });
                }
            }
        }
    }
    if minball.is_none() {
        -1
    } else {
        minball.unwrap() as isize
    }
}
