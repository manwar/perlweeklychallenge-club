#![deny(missing_docs)]
#![deny(clippy::missing_docs_in_private_items)]
// SPDX-FileCopyrightText: Peter Pentchev <roam@ringlet.net>
// SPDX-License-Identifier: BSD-2-Clause
//! PWC 289 task 1: Third Maximum

use std::env;
use std::io;
use std::iter::FusedIterator;
use std::process::{ExitCode, Termination};
use std::str::FromStr;

use anyhow::{bail, Context, Result};
use tracing::{debug, trace};

/// The example sequences from the problem to test against.
const TEST_SEQUENCES: [&[u32]; 3] = [&[5, 6, 4, 1], &[4, 5], &[1, 2, 2, 3]];

/// The result of the main program or an invoked subcommand.
enum MainResult {
    /// Everything seems fine.
    Ok,
}

impl Termination for MainResult {
    fn report(self) -> ExitCode {
        match self {
            Self::Ok => ExitCode::SUCCESS,
        }
    }
}

/// The state for running a single number through the collected maxima.
#[derive(Debug)]
struct MaxState<I: Iterator<Item = u32>> {
    /// The iterator over the maxima collected so far.
    it: I,

    /// The value stored from the last step, if any.
    stashed: Option<u32>,

    /// Have we reached the end yet?
    done: bool,
}

impl<I: Iterator<Item = u32>> MaxState<I> {
    /// Construct a [`MaxState`] iterator over the supplied one.
    #[inline]
    #[must_use]
    const fn new(it: I, stashed: u32) -> Self {
        Self {
            it,
            stashed: Some(stashed),
            done: false,
        }
    }
}

impl<I: Iterator<Item = u32>> Iterator for MaxState<I> {
    type Item = u32;

    #[inline]
    fn next(&mut self) -> Option<Self::Item> {
        if self.done {
            return None;
        }

        match (self.it.next(), self.stashed.take()) {
            (None, None) => {
                self.done = true;
                self.stashed = None;
                None
            }

            (None, Some(stashed)) => {
                self.done = true;
                self.stashed = None;
                Some(stashed)
            }

            (Some(value), None) => Some(value),

            (Some(value), Some(stashed)) if stashed > value => {
                self.stashed = Some(value);
                Some(stashed)
            }

            (Some(value), Some(stashed)) if stashed == value => {
                self.stashed = None;
                Some(value)
            }

            (Some(value), Some(stashed)) => {
                self.stashed = Some(stashed);
                Some(value)
            }
        }
    }
}

impl<I: Iterator<Item = u32>> FusedIterator for MaxState<I> {}

/// Run each successive number through the [`MaxState`] iterator.
#[tracing::instrument]
fn third_max(seq: &[u32]) -> Result<u32> {
    debug!(
        "Processing a sequence of {count} numbers",
        count = seq.len(),
    );
    let res = seq.iter().fold(vec![], |acc, value| {
        trace!(?acc);
        MaxState::new(acc.into_iter(), *value).take(3).collect()
    });
    trace!(?res);
    match res[..] {
        [_, _, third] => Ok(third),
        [first, ..] => Ok(first),
        [] => bail!("No numbers at all?"),
    }
}

/// The main program - parse the environment settings, do something about it.
#[allow(clippy::print_stdout)]
fn main() -> Result<MainResult> {
    if env::var("PWC_FROM_STDIN").unwrap_or_else(|_| String::new()) == "1" {
        let mut line = String::new();
        io::stdin()
            .read_line(&mut line)
            .context("Could not read a line from the standard input stream")?;
        let seq = line
            .split_ascii_whitespace()
            .map(|word| {
                u32::from_str(word)
                    .with_context(|| format!("Could not parse '{word}' as a positive integer"))
            })
            .collect::<Result<Vec<_>, _>>()?;
        println!("{res}", res = third_max(&seq)?);
    } else {
        for test_seq in TEST_SEQUENCES {
            println!("{res}", res = third_max(test_seq)?);
        }
    }
    Ok(MainResult::Ok)
}

#[cfg(test)]
#[allow(clippy::panic_in_result_fn)]
#[allow(clippy::print_stdout)]
mod tests {
    use anyhow::Result;
    use rstest::rstest;
    use tracing_test::traced_test;

    #[traced_test]
    #[rstest]
    #[case(&[1], 1)]
    #[case(&[1, 1], 1)]
    #[case(&[1, 1, 1], 1)]
    #[case(&[1, 2], 2)]
    #[case(&[2, 1], 2)]
    #[case(&[1, 2, 3], 1)]
    #[case(&[1, 3, 2], 1)]
    #[case(&[2, 1, 3], 1)]
    #[case(&[2, 3, 1], 1)]
    #[case(&[3, 1, 2], 1)]
    #[case(&[3, 2, 1], 1)]
    #[case(&[1, 2, 3, 4], 2)]
    #[case(&[1, 2, 4, 3], 2)]
    #[case(&[3, 4, 1, 2], 2)]
    #[case(&[4, 3, 2, 1], 2)]
    #[case(&[1, 2, 3, 4, 3, 2, 1, 4, 2, 4, 1, 3], 2)]
    #[case(&[1, 2, 2, 1], 2)]
    fn test_third_max(#[case] seq: &[u32], #[case] expected: u32) -> Result<()> {
        println!();
        assert_eq!(super::third_max(seq)?, expected);
        Ok(())
    }
}
