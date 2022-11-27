fn flip_bits(n: u32) -> u32 {
    let all_ones = (n + 1).next_power_of_two() - 1;

    return n ^ all_ones;
}

// Run with either of:
//      rustc --test rust/ch-1.rs && ./ch-1
//      rustc        rust/ch-1.rs && ./ch-1 99999

fn main() {
    let n: u32 = std::env::args().nth(1).expect("missing command-line argument")
                                .parse().expect("failed to parse");

    println!("flip_bits({}) == {}", n, flip_bits(n));
}

#[test]fn task_example_01() { assert_eq!(flip_bits( 5), 2) }
#[test]fn task_example_02() { assert_eq!(flip_bits( 4), 3) }
#[test]fn task_example_03() { assert_eq!(flip_bits( 6), 1) }
#[test]fn test_range_1_64() {

    let got: Vec<u32> = (1..(64+1)).map(flip_bits).collect();

    assert_eq!(got, vec![
        0,
        1,  0,
        3,  2,  1,  0,
        7,  6,  5,  4,  3,  2,  1,  0,
       15, 14, 13, 12, 11, 10,  9,  8,  7,  6,  5,  4,  3,  2,  1,  0,
       31, 30, 29, 28, 27, 26, 25, 24, 23, 22, 21, 20, 19, 18, 17, 16,
       15, 14, 13, 12, 11, 10,  9,  8,  7,  6,  5,  4,  3,  2,  1,  0,
       63
    ])
}
