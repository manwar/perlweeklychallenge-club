#[allow(warnings)]
#[allow(clippy)]
mod bindings;

use bindings::ringlet::pwc315_t2_find_third::find_third;

struct FindThirdCase<'data> {
    sentence: &'data str,
    wfirst: &'data str,
    wsecond: &'data str,
    expected: &'data [&'data str],
}

#[expect(clippy::print_stdout, reason = "report test progress")]
fn check_find_third(tcase: &FindThirdCase<'_>) -> Result<(), String> {
    let desc = format!(
        "{sentence:?} {wfirst:?} {wsecond:?} {expected:?}",
        sentence = tcase.sentence,
        wfirst = tcase.wfirst,
        wsecond = tcase.wsecond,
        expected = tcase.expected
    );

    println!("Test case: {desc}");
    let res = find_third::find_third(tcase.sentence, tcase.wfirst, tcase.wsecond);

    if res == tcase.expected {
        Ok(())
    } else {
        Err(format!("FAILED {desc} got {res:?}",))
    }
}

#[expect(clippy::print_stderr, reason = "report test failures")]
fn main() -> Result<(), usize> {
    let test_cases = vec![
        FindThirdCase {
            sentence: "Perl is a my favourite language but Python is my favourite too.",
            wfirst: "my",
            wsecond: "favourite",
            expected: &["language", "too"],
        },
        FindThirdCase {
            sentence: "Barbie is a beautiful doll also also a beautiful princess.",
            wfirst: "a",
            wsecond: "beautiful",
            expected: &["doll", "princess"],
        },
        FindThirdCase {
            sentence: "we will we will rock you rock you.",
            wfirst: "we",
            wsecond: "will",
            expected: &["we", "rock"],
        },
    ];

    let failed = test_cases
        .into_iter()
        .map(|tcase| {
            if let Err(err) = check_find_third(&tcase) {
                eprintln!("{err}");
                1
            } else {
                0
            }
        })
        .sum();
    if failed > 0 { Err(failed) } else { Ok(()) }
}
