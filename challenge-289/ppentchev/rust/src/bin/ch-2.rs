#![deny(missing_docs)]
#![deny(clippy::missing_docs_in_private_items)]
// SPDX-FileCopyrightText: Peter Pentchev <roam@ringlet.net>
// SPDX-License-Identifier: BSD-2-Clause
//! PWC 289 task 2: Jumbled Letters

use std::io;
use std::process::{ExitCode, Termination};

use anyhow::{Context, Result};
use rand::rngs::ThreadRng;
use rand::seq::index as r_idx;

/// The result of executing the program.
#[derive(Debug)]
enum MainResult {
    /// Everything went file.
    Ok,
}

impl Termination for MainResult {
    fn report(self) -> ExitCode {
        match self {
            Self::Ok => ExitCode::SUCCESS,
        }
    }
}

/// The state of the "grab a word's characters to jumble" machine.
#[derive(Debug)]
enum State {
    /// We are not in a word.
    Outside,

    /// Got the first character of a word.
    First(char),

    /// Inside a word.
    Inside(char, Vec<char>),
}

/// Shuffle the letters in a single word, if there are enough of them.
#[allow(clippy::print_stdout)]
fn jumble_word(rng: &mut ThreadRng, first: char, mut letters: Vec<char>, term_opt: Option<char>) {
    print!("{first}");
    if let Some(last) = letters.pop() {
        let indices = r_idx::sample(rng, letters.len(), letters.len());
        // Let's hope rand::seq::index::sample() works correctly
        #[allow(clippy::indexing_slicing)]
        let res = indices
            .into_iter()
            .map(|idx| letters[idx])
            .collect::<String>();
        print!("{res}{last}");
    }
    if let Some(term) = term_opt {
        print!("{term}");
    }
}

/// Read a file, sort the characters in each word, display them on stdout.
#[allow(clippy::print_stdout)]
fn jumble_stdin() -> Result<MainResult> {
    let mut rng = rand::thread_rng();
    for line_res in io::stdin().lines() {
        let line = line_res.context("Could not read a line from the standard input stream")?;
        let res = line
            .chars()
            .try_fold(State::Outside, |state, chr| -> Result<State> {
                match (state, chr.is_ascii_alphabetic()) {
                    (State::Outside, false) => {
                        print!("{chr}");
                        Ok(State::Outside)
                    }
                    (State::Outside, true) => Ok(State::First(chr)),
                    (State::First(first), false) => {
                        print!("{first}{chr}");
                        Ok(State::Outside)
                    }
                    (State::First(first), true) => Ok(State::Inside(first, vec![chr])),
                    (State::Inside(first, letters), false) => {
                        jumble_word(&mut rng, first, letters, Some(chr));
                        Ok(State::Outside)
                    }
                    (State::Inside(first, mut letters), true) => {
                        letters.push(chr);
                        Ok(State::Inside(first, letters))
                    }
                }
            })?;
        match res {
            State::Outside => (),
            State::First(first) => print!("{first}"),
            State::Inside(first, letters) => {
                jumble_word(&mut rng, first, letters, None);
            }
        };
        println!();
    }
    Ok(MainResult::Ok)
}

fn main() -> Result<MainResult> {
    jumble_stdin()
}

#[cfg(test)]
#[allow(clippy::panic_in_result_fn)]
mod tests {
    use std::env;
    use std::path::PathBuf;
    use std::process::{Command, Stdio};

    use anyhow::{anyhow, Context, Result};
    use camino::Utf8PathBuf;
    use rstest::rstest;

    #[derive(Debug)]
    struct Programs {
        /// The program to be tested.
        testee: Utf8PathBuf,

        /// The program to be tested.
        tester: Utf8PathBuf,

        /// The "unjumble this word" program.
        unjumble: Utf8PathBuf,
    }

    fn find_programs() -> Result<Programs> {
        let self_exe = Utf8PathBuf::from_path_buf(
            env::current_exe().context("Could not find our own test executable file")?,
        )
        .map_err(|obuf| {
            anyhow!(
                "Could not represent the test executable path {obuf} as an UTF-8 string",
                obuf = obuf.display()
            )
        })?;
        let pdir = {
            let self_parent = self_exe
                .parent()
                .ok_or_else(|| anyhow!("Could not determine a parent for {self_exe}"))?;
            let parent_filename = self_parent
                .file_name()
                .ok_or_else(|| anyhow!("Could not determine a filename for {self_parent}"))?;
            if parent_filename == "deps" {
                self_parent
                    .parent()
                    .ok_or_else(|| anyhow!("Could not determine a parent for {self_parent}"))?
            } else {
                self_parent
            }
        };
        Ok(Programs {
            testee: pdir.join("ch-2"),
            tester: pdir.join("test-jumble"),
            unjumble: pdir.join("unjumble"),
        })
    }

    #[rstest]
    fn test_jumble_bin(
        #[files("../test-data/jumbled-letters/*.txt")] infile_buf: PathBuf,
    ) -> Result<()> {
        #[allow(clippy::print_stdout)]
        {
            println!();
        }
        let programs = find_programs()?;
        let infile = Utf8PathBuf::from_path_buf(infile_buf).map_err(|path| {
            anyhow!(
                "Could not parse {path} as a UTF-8 pathname",
                path = path.display()
            )
        })?;
        assert!(Command::new(&programs.tester)
            .args([
                "--unjumble-program",
                programs.unjumble.as_ref(),
                "--jumble-program",
                programs.testee.as_ref(),
                "--",
                infile.as_ref(),
            ])
            .stdin(Stdio::null())
            .status()
            .with_context(|| format!("Could not run {tester}", tester = programs.tester))?
            .success());
        Ok(())
    }
}
