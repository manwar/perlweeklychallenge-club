use std::ops::Deref;
use num_traits::Bounded;

// Alternate impl as an iterator

fn main() {
    let a = vec![7, 8, 3, 12, 10];
    let o: Vec<i32> = doit(&a);
    assert_eq!(o, vec![0, 7, 0, 3, 3]);

    let a = vec![4, 6, 5];
    let o: Vec<i32> = doit(&a);
    assert_eq!(o, vec![0, 4, 4]);
}

fn doit(a: &Vec<i32>) -> Vec<i32> {
    MinLeft::new(a.iter()).collect()
}

struct MinLeft<I, T: Bounded + Copy + Ord + Default> {
    a: I,
    min: T,
}

impl<I, T: Bounded + Copy + Ord + Default> MinLeft<I, T> {
    fn new(a: I) -> MinLeft<I, T> {
        MinLeft {
            a,
            min: T::max_value(),
        }
    }
}

impl<'a, T: Bounded + Copy + Ord + Default, P: Deref<Target=T>, I: Iterator<Item=P>> Iterator for MinLeft<I, T> {
    type Item = T;

    fn next(&mut self) -> Option<Self::Item> {
        match self.a.next() {
            Some(next) => {
                let result = if self.min < *next { self.min } else { Default::default() };
                self.min = self.min.min(*next);
                Some(result)
            },
            None => None
        }
    }
}
