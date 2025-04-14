use anyhow::{Result, ensure};

use crate::bindings::ringlet::pwc317_t2_frings::frings;

mod bindings;

#[derive(Debug)]
struct FringsTestCase<'data> {
    str1: &'data str,
    str2: &'data str,
    expected: bool,
}

fn main() -> Result<()> {
    let test_cases = [
        FringsTestCase {
            str1: "desc",
            str2: "dsec",
            expected: true,
        },
        FringsTestCase {
            str1: "duck",
            str2: "dcuk",
            expected: true,
        },
        FringsTestCase {
            str1: "poo",
            str2: "eop",
            expected: false,
        },
        FringsTestCase {
            str1: "stripe",
            str2: "sprite",
            expected: true,
        },
    ];

    let passed = test_cases.into_iter().fold(true, |acc, tcase| {
        println!("Test case: '{str1}'", str1 = tcase.str1);
        let res = frings::frings(tcase.str1, tcase.str2);
        if res != tcase.expected {
            eprintln!(
                "FAILED str1 {str1:?} str2 {str2:?} expected {expected} got {res}",
                str1 = tcase.str1,
                str2 = tcase.str2,
                expected = tcase.expected
            );
            false
        } else {
            acc
        }
    });
    ensure!(passed, "Some tests failed");
    Ok(())
}
