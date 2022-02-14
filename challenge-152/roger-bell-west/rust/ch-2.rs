#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

use std::cmp::{max, min};

#[test]
fn test_ex1() {
    assert_eq!(
        Rect::new([-1, 0], [2, 2]).fullarea(Rect::new([0, -1], [4, 4])),
        22
    );
}

#[test]
fn test_ex2() {
    assert_eq!(
        Rect::new([-3, -1], [1, 3]).fullarea(Rect::new([-1, -3], [2, 2])),
        25
    );
}

pub struct Rect {
    xy1: [i32; 2],
    xy2: [i32; 2],
}

impl Rect {
    pub fn new(xy1: [i32; 2], xy2: [i32; 2]) -> Rect {
        Rect {
            xy1: [min(xy1[0], xy2[0]), min(xy1[1], xy2[1])],
            xy2: [max(xy1[0], xy2[0]), max(xy1[1], xy2[1])],
        }
    }

    pub fn area(&self) -> i32 {
        let mut area = 1;
        for axis in 0..=1 {
            area *= self.xy2[axis] - self.xy1[axis];
        }
        return area;
    }

    pub fn overlap(&self, other: Rect) -> i32 {
        let mut area = 1;
        for axis in 0..=1 {
            area *= max(
                0,
                min(self.xy2[axis], other.xy2[axis])
                    - max(self.xy1[axis], other.xy1[axis]),
            );
        }
        return area;
    }

    pub fn fullarea(&self, other: Rect) -> i32 {
        return self.area() + other.area() - self.overlap(other);
    }
}
