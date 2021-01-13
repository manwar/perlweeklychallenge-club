#![allow(dead_code)]

use std::env;

fn main() {
    let n = env::args().skip(1).next().expect("Missing argument 'n'")
        .parse().expect("Broken argument 'n' - expected number");

    let total_count_set_bit = doit_optimized(n);

    println!("{}", total_count_set_bit);
}

const N_BITS: u32 = 128;
type NType = u128;

fn doit_naive(n: NType) -> u32 {
    let mut res: NType = 0;
    for i in 1..=n {
        res += i.count_ones() as NType;
    }
    (res % 1000000007) as u32
}

fn doit_optimized(mut n: NType) -> u32 {
    n += 1; // convert to exclusive upper end
    let mut res = 0;
    let mut leading_bits = 0;
    loop {
        let highest_bit_plus_1 = N_BITS - n.leading_zeros();
        if highest_bit_plus_1 < 1 {
            break;
        }
        let mask = 1 << (highest_bit_plus_1 - 1);

        res += mask * leading_bits + doit_pow2(mask);

        // next iteration
        n -= mask;
        leading_bits += 1;
    }
    (res % 1000000007) as u32
}

// quickly calculate bits in 0..n-1 where n = 2^k
fn doit_pow2(n: NType) -> NType {
    (N_BITS - n.leading_zeros() - 1) as NType * n / 2
}

#[cfg(test)]
mod tests {
    use crate::{doit_naive, doit_optimized};

    #[test]
    fn identical_results_for_0_to_1000() {
        for n in 1..1000 {
            assert_eq!(doit_naive(n), doit_optimized(n), "for n={}", n);
        }
    }
}
