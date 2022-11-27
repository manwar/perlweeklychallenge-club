// Run with either of:
//      rustc --test rust/ch-2.rs && ./ch-2
//      rustc        rust/ch-2.rs && ./ch-2 3 6 3

fn task2 ( a : Vec<i32> ) -> i32 {
    let sum : i32 = a.iter().sum();
    let len : i32 = a.len() as i32;

    if sum % len != 0 {
        return -1;
    }

    let target = sum / len;

    // Raku code: (  [\+] ( @a X- target )  )».abs.sum
    return a.iter()
            .scan(0, |state, &x| { *state += x - target; Some(*state) })
            .map(|x| { x.abs() })
            .sum();
}

fn main () {
    let input : Vec<i32> = std::env::args()
        .skip(1)
        .map(|x| { x.parse::<i32>().unwrap() })
        .collect();

    assert!( !input.is_empty(), "Error: Need integer arguments on the command-line" );

    println!("task2({:?}) = {:?}", input.clone(), task2(input));
}

#[test]fn task_example_01() { assert_eq!(task2( vec![1, 0, 5] ),  4) }
#[test]fn task_example_02() { assert_eq!(task2( vec![0, 2, 0] ), -1) }
#[test]fn task_example_03() { assert_eq!(task2( vec![0, 3, 0] ),  2) }

#[test]fn test_misc_01()    { assert_eq!(task2( vec![4,0,0,0] ),  6) }
#[test]fn test_misc_02()    { assert_eq!(task2( vec![3,1,0,0] ),  5) }
#[test]fn test_misc_03()    { assert_eq!(task2( vec![3,0,1,0] ),  4) }
#[test]fn test_misc_04()    { assert_eq!(task2( vec![3,0,0,1] ),  3) }
#[test]fn test_misc_05()    { assert_eq!(task2( vec![2,2,0,0] ),  4) }
#[test]fn test_misc_06()    { assert_eq!(task2( vec![2,0,2,0] ),  2) }
#[test]fn test_misc_07()    { assert_eq!(task2( vec![2,0,0,2] ),  2) }
#[test]fn test_misc_08()    { assert_eq!(task2( vec![2,1,1,0] ),  3) }
#[test]fn test_misc_09()    { assert_eq!(task2( vec![2,1,0,1] ),  2) }
#[test]fn test_misc_10()    { assert_eq!(task2( vec![2,0,1,1] ),  1) }
#[test]fn test_misc_11()    { assert_eq!(task2( vec![1,1,1,1] ),  0) }
#[test]fn test_misc_12()    { assert_eq!(task2( vec![1,2,1,0] ),  2) }
#[test]fn test_misc_13()    { assert_eq!(task2( vec![1,2,0,1] ),  1) }
#[test]fn test_misc_14()    { assert_eq!(task2( vec![1,1,2,0] ),  1) }
#[test]fn test_misc_15()    { assert_eq!(task2( vec![1,1,0,2] ),  1) }

#[test]fn test_large_01() {
    let got = task2( vec![2 + (8*1000), 2, 2, 2, 2, 2, 2, 2] );
    let expected = 1000 * (1..(7+1)).sum::<i32>();
    assert_eq!(got, expected);
}
#[test]fn test_large_02() {
    let got = task2( vec![2, 2, 2, 2, 2, 2, 2, 2 + (8*1000)] );
    let expected = 1000 * (1..(7+1)).sum::<i32>();
    assert_eq!(got, expected);
}
#[test]fn test_large_03() {
    let got = task2( vec![2, 2, 2, 2, 2, 2, 2 + (8*1000), 2] );
    let expected = 1000 * (1+(1..(6+1)).sum::<i32>());
    assert_eq!(got, expected);
}

#[test]fn for_blog_post_01() {
    let got = task2( vec![6,3,3,3,3,0,3,3,3,3,0,1,3,3,3,6,5] );
    let expected = 15+15+10;
    assert_eq!(got, expected);
}
