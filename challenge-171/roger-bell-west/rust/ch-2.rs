#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    let f = |x| x + 1;
    let g = |x| x * 2;
    let h = compose(f, g);
    for i in 1..=10 {
        assert_eq!(f(g(i)), h(i));
    }
}

// found this at https://stackoverflow.com/posts/45792463/revisions
fn compose<A, B, C, G, F>(f: F, g: G) -> impl Fn(A) -> C
where
    F: Fn(B) -> C,
    G: Fn(A) -> B,
{
    move |x| f(g(x))
}
