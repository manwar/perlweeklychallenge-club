#![deny(missing_docs)]
#![deny(clippy::missing_docs_in_private_items)]
// SPDX-FileCopyrightText: Peter Pentchev <roam@ringlet.net>
// SPDX-License-Identifier: BSD-2-Clause
//! PWC 289 helper: run the jumble program, compare its output with the expected one.

use std::fs::File;
use std::process::{Command, ExitCode, Stdio, Termination};

use anyhow::{bail, Context, Result};
use camino::{Utf8Path, Utf8PathBuf};
use clap::error::ErrorKind as ClapErrorKind;
use clap::Parser;
use clap_derive::Parser;
use tempfile::Builder;

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
    /// The program to test (the one that jumbles the words).
    testee: Utf8PathBuf,

    /// The program that sorts the letters in each word.
    unjumble: Utf8PathBuf,

    /// The file to jumble.
    filename: Utf8PathBuf,
}

impl Config {
    /// The program to test (the one that jumbles the words).
    fn testee(&self) -> &Utf8Path {
        &self.testee
    }

    /// The program that sorts the letters in each word.
    fn unjumble(&self) -> &Utf8Path {
        &self.unjumble
    }

    /// The file to jumble.
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
    TestJumble(Config),
}

/// The command-line arguments.
#[derive(Debug, Parser)]
struct Cli {
    /// The program to test (the one that jumbles the words).
    #[clap(short('j'), long, required(true))]
    jumble_program: Utf8PathBuf,

    /// The program that sorts the letters in each word.
    #[clap(short('u'), long, required(true))]
    unjumble_program: Utf8PathBuf,

    /// The file to jumble.
    filename: Utf8PathBuf,
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
    Ok(Mode::TestJumble(Config {
        testee: args.jumble_program,
        unjumble: args.unjumble_program,
        filename: args.filename,
    }))
}

/// Use `cmp(1)` to decide whether two files are the same or not.
fn same_files(src: &Utf8Path, dst: &Utf8Path) -> Result<bool> {
    Ok(Command::new("cmp")
        .args(["--", src.as_ref(), dst.as_ref()])
        .stdin(Stdio::null())
        .stdout(Stdio::null())
        .stderr(Stdio::null())
        .output()
        .with_context(|| format!("Could not run `cmp -- {src} {dst}`"))?
        .status
        .success())
}

/// Run the jumble program ten times, sort its output, look for consistency and changes.
#[allow(clippy::print_stdout)]
fn test_jumble(cfg: &Config) -> Result<MainResult> {
    let sorted_file = cfg.filename().with_extension("txt.sorted");
    let same = same_files(cfg.filename(), &sorted_file)?;
    let changed = (1_u32..=10_u32).try_fold(false, |changed, idx| -> Result<bool> {
        println!(
            "Iteration {idx}: running {testee} on {infile}",
            testee = cfg.testee(),
            infile = cfg.filename(),
        );
        let temp_obj = Builder::new()
            .tempfile()
            .context("Could not create a temporary file")?;
        let temp_path = Utf8Path::from_path(temp_obj.path()).with_context(|| {
            format!(
                "Could not parse {path} as a UTF-8 path",
                path = temp_obj.path().display()
            )
        })?;
        let temp_sorted_obj = Builder::new()
            .tempfile()
            .context("Could not create a temporary file")?;
        let temp_sorted_path = Utf8Path::from_path(temp_sorted_obj.path()).with_context(|| {
            format!(
                "Could not parse {path} as a UTF-8 path",
                path = temp_sorted_obj.path().display()
            )
        })?;

        if !Command::new(cfg.testee())
            .stdin(File::open(cfg.filename()).with_context(|| {
                format!(
                    "Could not open {infile} for reading",
                    infile = cfg.filename()
                )
            })?)
            .stdout(
                File::options()
                    .write(true)
                    .open(temp_path)
                    .with_context(|| format!("Could not open {temp_path} for writing"))?,
            )
            .stderr(Stdio::inherit())
            .status()
            .with_context(|| format!("Could not run {testee}", testee = cfg.testee()))?
            .success()
        {
            bail!(
                "Could not run {testee} on {infile} into {temp_path}",
                testee = cfg.testee(),
                infile = cfg.filename()
            );
        }

        if !Command::new(cfg.unjumble())
            .arg(temp_path)
            .stdout(
                File::options()
                    .write(true)
                    .open(temp_sorted_path)
                    .with_context(|| format!("Could not open {temp_sorted_path} for writing"))?,
            )
            .stderr(Stdio::inherit())
            .status()
            .with_context(|| format!("Could not run {tester}", tester = cfg.unjumble()))?
            .success()
        {
            bail!(
                "Could not run {tester} on {temp_path} into {temp_sorted_path}",
                tester = cfg.unjumble(),
            );
        }

        if !same_files(temp_sorted_path, &sorted_file)? {
            bail!(
                "Running {testee} on {infile} did not produce the expected words",
                testee = cfg.testee(),
                infile = cfg.filename()
            );
        }

        let changed_now = !same_files(temp_path, cfg.filename())?;
        println!("- at iteration {idx}: changed {changed_now}");
        Ok(changed || changed_now)
    })?;

    if changed == same {
        bail!(
            "At least one run of {testee} should have changed the input file {infile}",
            testee = cfg.testee(),
            infile = cfg.filename()
        );
    }
    Ok(MainResult::Ok)
}

fn main() -> Result<MainResult> {
    match try_parse()? {
        Mode::Handled => Ok(MainResult::Ok),
        Mode::TestJumble(cfg) => test_jumble(&cfg),
    }
}
