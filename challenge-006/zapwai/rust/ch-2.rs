use num_bigfloat::{BigFloat, PI};
use std::convert::From;

fn main() {
    let x :BigFloat = PI*(BigFloat::from(163).sqrt());
    let xe = x.exp();
    println!("{}", xe);
}
