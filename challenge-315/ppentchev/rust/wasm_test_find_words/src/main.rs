#[allow(warnings)]
#[allow(clippy)]
mod bindings;

use bindings::ringlet::pwc315_t1_find_words::find_words;

struct FindWordsCase<'data> {
    wlist: &'data [&'data str],
    wchar: char,
    expected: &'data [u32],
}

#[expect(clippy::print_stdout, reason = "report test progress")]
fn check_find_words(tcase: &FindWordsCase<'_>) -> Result<(), String> {
    let desc = format!(
        "{wlist:?} {wchar:?} {expected:?}",
        wlist = tcase.wlist,
        wchar = tcase.wchar,
        expected = tcase.expected
    );

    println!("Test case: {desc}");
    let wlist_str: Vec<String> = tcase.wlist.iter().map(|word| (*word).to_owned()).collect();
    let res = find_words::find_words(&wlist_str, tcase.wchar);

    if res == tcase.expected {
        Ok(())
    } else {
        Err(format!("FAILED {desc} got {res:?}",))
    }
}

#[expect(clippy::print_stderr, reason = "report test failures")]
fn main() -> Result<(), usize> {
    let test_cases = vec![
        FindWordsCase {
            wlist: &["the", "weekly", "challenge"],
            wchar: 'e',
            expected: &[0, 1, 2],
        },
        FindWordsCase {
            wlist: &["perl", "raku", "python"],
            wchar: 'p',
            expected: &[0, 2],
        },
        FindWordsCase {
            wlist: &["abc", "def", "bbb", "bcd"],
            wchar: 'b',
            expected: &[0, 2, 3],
        },
    ];

    let failed = test_cases
        .into_iter()
        .map(|tcase| {
            if let Err(err) = check_find_words(&tcase) {
                eprintln!("{err}");
                1
            } else {
                0
            }
        })
        .sum();
    if failed > 0 { Err(failed) } else { Ok(()) }
}
