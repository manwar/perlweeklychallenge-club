#!/bin/sh
//usr/bin/env rustc --test $0 -o kachow && ./kachow --nocapture; rm -f kachow ; exit

fn straight_line(points: &[[i64; 2]]) -> bool {
    if points.len() <= 2 {
        return true;
    }

    let [x1, y1] = points[0];
    let [x2, y2] = points[1];

    points[2..]
        .iter()
        .all(|&[x3, y3]| (y2 - y1) * (x3 - x1) == (y3 - y1) * (x2 - x1))
}

#[test]
fn example() {
    assert_eq!(straight_line(&[[2, 1], [2, 3], [2, 5]]), true);
    assert_eq!(straight_line(&[[1, 4], [3, 4], [10, 4]]), true);
    assert_eq!(straight_line(&[[0, 0], [1, 1], [2, 3]]), false);
    assert_eq!(straight_line(&[[1, 1], [1, 1], [1, 1]]), true);
    assert_eq!(
        straight_line(&[[1000000, 1000000], [2000000, 2000000], [3000000, 3000000]]),
        true
    );
}
