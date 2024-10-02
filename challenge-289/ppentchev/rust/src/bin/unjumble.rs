#![deny(missing_docs)]
#![deny(clippy::missing_docs_in_private_items)]
// SPDX-FileCopyrightText: Peter Pentchev <roam@ringlet.net>
// SPDX-License-Identifier: BSD-2-Clause
//! PWC 289 helper: unjumble the words in a text file

use std::fs;
use std::process::{ExitCode, Termination};

use anyhow::{bail, Context, Result};
use camino::{Utf8Path, Utf8PathBuf};
use clap::error::ErrorKind as ClapErrorKind;
use clap::Parser;
use clap_derive::Parser;
use itertools::Itertools;

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

/// Runtime configuration for the unjumble tool.
#[derive(Debug)]
struct Config {
    /// The file to unjumble.
    filename: Utf8PathBuf,
}

impl Config {
    /// Construct a [`Config`] object with the specified filename.
    const fn new(filename: Utf8PathBuf) -> Self {
        Self { filename }
    }

    /// The file to unjumble.
    fn filename(&self) -> &Utf8Path {
        &self.filename
    }
}

/// What we should do.
#[derive(Debug)]
enum Mode {
    /// Everything was handled already.
    Handled,

    /// Unjumble the words from a file.
    Unjumble(Config),
}

/// The command-line arguments.
#[derive(Debug, Parser)]
struct Cli {
    /// The file to unjumble.
    filename: Utf8PathBuf,
}

/// The state of the "grab a word's characters to sort" machine.
#[derive(Debug)]
enum State {
    /// We are not in a word.
    Outside,

    /// Got the first character of a word.
    First(char),

    /// Inside a word.
    Inside(char, Vec<char>),
}

/// Parse the command-line arguments, determine the mode of operation.
///
/// # Errors
///
/// Propagate command-line parsing errors.
fn try_parse() -> Result<Mode> {
    let args = match Cli::try_parse() {
        Ok(args) => args,
        Err(err)
            if matches!(
                err.kind(),
                ClapErrorKind::DisplayHelp | ClapErrorKind::DisplayVersion
            ) =>
        {
            err.print()
                .context("Could not display the help or version output")?;
            return Ok(Mode::Handled);
        }
        Err(err) if err.kind() == ClapErrorKind::DisplayHelpOnMissingArgumentOrSubcommand => {
            err.print()
                .context("Could not display the usage or version message")?;
            bail!("Invalid or missing command-line options");
        }
        Err(err) => return Err(err).context("Could not parse the command-line options"),
    };
    Ok(Mode::Unjumble(Config::new(args.filename)))
}

/// Sort the letters in a single word, if there are enough of them.
#[allow(clippy::print_stdout)]
fn unjumble_word(first: char, mut letters: Vec<char>, term: Option<char>) {
    print!("{first}");
    if let Some(last) = letters.pop() {
        letters.sort_unstable();
        print!("{letters}{last}", letters = letters.into_iter().join(""));
    }
    if let Some(term_chr) = term {
        print!("{term_chr}");
    }
}

/// Read a file, sort the characters in each word, display them on stdout.
#[allow(clippy::print_stdout)]
fn unjumble_file(cfg: &Config) -> Result<MainResult> {
    let contents = fs::read_to_string(cfg.filename()).with_context(|| {
        format!(
            "Could not read the contents of {filename}",
            filename = cfg.filename()
        )
    })?;
    for line in contents.lines() {
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
                        unjumble_word(first, letters, Some(chr));
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
                unjumble_word(first, letters, None);
            }
        };
        println!();
    }
    Ok(MainResult::Ok)
}

fn main() -> Result<MainResult> {
    match try_parse()? {
        Mode::Handled => Ok(MainResult::Ok),
        Mode::Unjumble(cfg) => unjumble_file(&cfg),
    }
}

#[cfg(test)]
#[allow(clippy::panic_in_result_fn)]
mod tests {
    use std::env;
    use std::fs;
    use std::path::PathBuf;
    use std::process::{Command, Stdio};

    use anyhow::{anyhow, Context, Result};
    use camino::Utf8PathBuf;
    use rstest::rstest;

    fn find_program() -> Result<Utf8PathBuf> {
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
        Ok(pdir.join("unjumble"))
    }

    #[rstest]
    fn test_unjumble_bin(
        #[files("../test-data/jumbled-letters/*.txt")] infile_buf: PathBuf,
    ) -> Result<()> {
        let prog = find_program()?;
        let infile = Utf8PathBuf::from_path_buf(infile_buf).map_err(|path| {
            anyhow!(
                "Could not parse {path} as a UTF-8 pathname",
                path = path.display()
            )
        })?;
        let sorted_file = infile.with_extension("txt.sorted");

        let expected = fs::read_to_string(&sorted_file)
            .with_context(|| format!("Could not read the contents of {sorted_file}"))?;
        let output = Command::new(&prog)
            .arg(&infile)
            .stdin(Stdio::null())
            .stdout(Stdio::piped())
            .stderr(Stdio::inherit())
            .output()
            .with_context(|| format!("Could not run `{prog} {infile}`"))?;
        assert!(output.status.success());
        let result = String::from_utf8(output.stdout).with_context(|| {
            format!("Could not parse the output of `{prog} {infile}` as a UTF-8 string")
        })?;
        assert_eq!(result, expected);
        Ok(())
    }
}
