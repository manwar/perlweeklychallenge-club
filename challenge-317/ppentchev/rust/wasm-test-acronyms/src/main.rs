use anyhow::{Result, ensure};

use crate::bindings::ringlet::pwc317_t1_acronyms::acronyms;

mod bindings;

#[derive(Debug)]
struct AcronymsTestCase<'data> {
    wlist: Vec<&'data str>,
    word: &'data str,
    expected: bool,
}

fn main() -> Result<()> {
    let test_cases = [
        AcronymsTestCase {
            wlist: vec!["Perl", "Weekly", "Challenge"],
            word: "PWC",
            expected: true,
        },
        AcronymsTestCase {
            wlist: vec!["Bob", "Charlie", "Joe"],
            word: "BCJ",
            expected: true,
        },
        AcronymsTestCase {
            wlist: vec!["Morning", "Good"],
            word: "MM",
            expected: false,
        },
    ];

    let passed = test_cases.into_iter().fold(true, |acc, tcase| {
        println!("Test case: '{word}'", word = tcase.word);
        let res = acronyms::acronyms(
            &tcase
                .wlist
                .iter()
                .map(|value| (*value).to_owned())
                .collect::<Vec<_>>(),
            tcase.word,
        );
        if res != tcase.expected {
            eprintln!(
                "FAILED wlist {wlist:?} word {word:?} expected {expected} got {res}",
                wlist = tcase.wlist,
                word = tcase.word,
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
