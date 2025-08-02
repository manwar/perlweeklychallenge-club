#![deny(missing_docs)]
#![deny(clippy::missing_docs_in_private_items)]
// SPDX-FileCopyrightText: Peter Pentchev <roam@ringlet.net>
// SPDX-License-Identifier: BSD-2-Clause
//! PWC 287 task 1: Strong Password

use std::collections::HashSet;
use std::env;
use std::io;
use std::process::{ExitCode, Termination};

use anyhow::{anyhow, Context, Result};
use tracing::{debug, trace, Level};

/// The examples from the problem.
const TEST_STRINGS: [&str; 5] = ["a", "aB2", "PaaSW0rd", "PaaaSW0rd", "aaaaa"];

/// The minimum length for a password considered strong.
const DESIRED_LENGTH: usize = 6;

/// The recognized character classes.
#[derive(Debug, PartialEq, Eq, Hash)]
enum CharClass {
    /// A lowercase letter.
    Lower,

    /// An uppercase letter.
    Upper,

    /// A digit.
    Digit,
}

impl CharClass {
    /// Examine a character, return a possible character class.
    const fn from_char(value: char) -> Option<Self> {
        if value.is_ascii_lowercase() {
            Some(Self::Lower)
        } else if value.is_ascii_uppercase() {
            Some(Self::Upper)
        } else if value.is_ascii_digit() {
            Some(Self::Digit)
        } else {
            None
        }
    }
}

/// The current state of examining the password string for length and character classes.
#[derive(Debug, Default)]
struct RunState {
    /// The character classes found so far.
    classes: HashSet<CharClass>,

    /// The runs collected so far.
    runs: Vec<usize>,

    /// The last character seen.
    last: char,

    /// The number of times the last character was seen.
    seen: usize,
}

impl RunState {
    /// Process a single character, update the runs state and the missing classes.
    #[allow(clippy::arithmetic_side_effects)]
    #[allow(clippy::integer_division)]
    fn update(mut self, value: char) -> Self {
        if let Some(class) = CharClass::from_char(value) {
            self.classes.insert(class);
        }

        if value == self.last {
            self.seen += 1;
        } else {
            if self.seen >= 3 {
                self.runs.push(self.seen);
            }
            self.last = value;
            self.seen = 1;
        }

        self
    }

    /// Record the count of the last run of characters if needed.
    fn update_finish(mut self) -> Self {
        if self.seen >= 3 {
            self.runs.push(self.seen);
        }
        self
    }
}

/// The various attributes determining the password strength.
#[derive(Debug)]
struct Strength {
    /// The number of actions taken to increase the password strength.
    actions: usize,

    /// The current length of the password.
    length: usize,

    /// The number of missing character classes.
    missing: usize,

    /// The respective lengths of the too-long runs of the same character.
    runs: Vec<usize>,
}

impl Strength {
    /// Diagnostic output.
    fn diag(&self, tag: &str) {
        debug!(
            "state {tag}: actions {actions}, length {length}, missing {missing}, runs {runs:?}",
            actions = self.actions,
            length = self.length,
            missing = self.missing,
            runs = self.runs
        );
    }

    /// Determine what changes need to be made to break successive runs of the same character.
    #[allow(clippy::integer_division)]
    #[allow(clippy::integer_division_remainder_used)]
    fn fix_runs(self) -> Result<Self> {
        let taken: usize = self.runs.into_iter().map(|run| run / 3).sum();
        let actions = if taken > 0 {
            self.actions.checked_add(taken).ok_or_else(|| {
                anyhow!(
                    "Could not add {taken} new actions to {current}",
                    current = self.actions
                )
            })?
        } else {
            self.actions
        };
        let missing = self.missing.saturating_sub(taken);
        Ok(Self {
            actions,
            missing,
            runs: vec![],
            ..self
        })
    }

    /// Determine what changes need to be made to bring the string to the desired length.
    fn fix_length(self) -> Result<Self> {
        let taken = DESIRED_LENGTH.saturating_sub(self.length);
        let actions = if taken > 0 {
            self.actions.checked_add(taken).ok_or_else(|| {
                anyhow!(
                    "Could not add {taken} new actions to {current}",
                    current = self.actions
                )
            })?
        } else {
            self.actions
        };
        let length = if taken > 0 {
            DESIRED_LENGTH
        } else {
            self.length
        };
        let missing = self.missing.saturating_sub(taken);
        Ok(Self {
            actions,
            length,
            missing,
            ..self
        })
    }

    /// Determine what changes need to be made to represent all the required character classes.
    fn fix_missing(self) -> Result<Self> {
        let taken = self.missing;
        let actions = if taken > 0 {
            self.actions.checked_add(taken).ok_or_else(|| {
                anyhow!(
                    "Could not add {taken} new actions to {current}",
                    current = self.actions
                )
            })?
        } else {
            self.actions
        };
        Ok(Self {
            actions,
            missing: 0,
            ..self
        })
    }
}

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

/// Perform the initial analysis on the password: length, runs, missing classes.
fn _examine_password(password: &str) -> Result<Strength> {
    let length = password.len();
    let state = password
        .chars()
        .fold(RunState::default(), RunState::update)
        .update_finish();
    trace!(?state);

    let missing = 3_usize.checked_sub(state.classes.len()).ok_or_else(|| {
        anyhow!(
            "Could not subtract {count} from 3",
            count = state.classes.len()
        )
    })?;

    Ok(Strength {
        actions: 0,
        length,
        missing,
        runs: state.runs,
    })
}

/// Calculate the task-dependent result.
#[tracing::instrument]
fn strong_password(password: &str) -> Result<usize> {
    debug!("Examining a password: {password:?}");
    let st_init = _examine_password(password)?;
    st_init.diag("init");

    let st_runs = st_init.fix_runs()?;
    st_runs.diag("runs");

    let st_length = st_runs.fix_length()?;
    st_length.diag("length");

    let st_missing = st_length.fix_missing()?;
    st_missing.diag("missing");

    Ok(st_missing.actions)
}

/// Initialize the logging subsystem provided by the `tracing` library.
fn setup_tracing() -> Result<()> {
    let quiet = env::var("PWC_QUIET").unwrap_or_else(|_| String::new()) == "1";
    let sub = tracing_subscriber::fmt()
        .without_time()
        .with_max_level(if quiet { Level::INFO } else { Level::TRACE })
        .with_writer(io::stderr)
        .finish();
    #[allow(clippy::absolute_paths)]
    tracing::subscriber::set_global_default(sub).context("Could not initialize the tracing logger")
}

/// The main program - parse the environment settings, do something about it.
#[allow(clippy::print_stdout)]
fn main() -> Result<MainResult> {
    setup_tracing()?;
    if env::var("PWC_FROM_STDIN").unwrap_or_else(|_| String::new()) == "1" {
        let mut line = String::new();
        io::stdin()
            .read_line(&mut line)
            .context("Could not read a line from the standard input stream")?;
        println!(
            "{res}",
            res = strong_password(line.trim_end_matches(&['\r', '\n']))?
        );
    } else {
        for password in TEST_STRINGS {
            println!("{res}", res = strong_password(password)?);
        }
    }
    Ok(MainResult::Ok)
}
