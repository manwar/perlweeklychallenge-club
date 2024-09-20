#![deny(missing_docs)]
#![deny(clippy::missing_docs_in_private_items)]
// SPDX-FileCopyrightText: Peter Pentchev <roam@ringlet.net>
// SPDX-License-Identifier: BSD-2-Clause
//! PWC 287 task 2: Valid Number

use std::env;
use std::io;
use std::process::{ExitCode, Termination};

use anyhow::{Context, Result};
use nom::{
    branch::alt,
    bytes::complete::tag,
    character::complete::one_of,
    combinator::{all_consuming, opt},
    multi::{many0, many1},
    sequence::tuple,
    IResult,
};
use tracing::debug;

/// The examples from the problem.
const TEST_NUMBERS: [&str; 7] = ["1", "a", ".", "1.2e4.2", "-1.", "+1E-8", ".44"];

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

/// Recognize a plus or minus sign at the start of the mantissa or the exponent.
fn _p_sign(input: &str) -> IResult<&str, ()> {
    let (r_input, _) = one_of("+-")(input)?;
    Ok((r_input, ()))
}

/// Recognize an ASCII decimal digit.
fn _p_digit(input: &str) -> IResult<&str, ()> {
    let (r_input, _) = one_of("0123456789")(input)?;
    Ok((r_input, ()))
}

/// Recognize a decimal dot maybe followed by some digits.
fn _p_large_fractional_part(input: &str) -> IResult<&str, ()> {
    let (r_input, _) = tuple((tag("."), many0(_p_digit)))(input)?;
    Ok((r_input, ()))
}

/// Recognize a number with some digits before the optional decimal dot, etc.
fn _p_large_number(input: &str) -> IResult<&str, ()> {
    let (r_input, _) = tuple((many1(_p_digit), opt(_p_large_fractional_part)))(input)?;
    Ok((r_input, ()))
}

/// Recognize a number between 0 and 1: a decimal dot and some digits.
fn _p_small_number(input: &str) -> IResult<&str, ()> {
    let (r_input, _) = tuple((tag("."), many1(_p_digit)))(input)?;
    Ok((r_input, ()))
}

/// Recognize a valid mantissa: sign, digits, decimal dot, etc.
fn _p_mantissa(input: &str) -> IResult<&str, ()> {
    let (r_input, _) = tuple((opt(_p_sign), alt((_p_large_number, _p_small_number))))(input)?;
    Ok((r_input, ()))
}

/// Recognize a valid `[Ee][+-]?{digits}` exponent, return the unit value on success.
fn _p_exponent(input: &str) -> IResult<&str, ()> {
    let (r_input, _) = tuple((one_of("Ee"), opt(_p_sign), many1(_p_digit)))(input)?;
    Ok((r_input, ()))
}

/// Recognize a valid number, return the unit value on success.
fn _p_valid_number(input: &str) -> IResult<&str, ()> {
    let (r_input, _) = all_consuming(tuple((_p_mantissa, opt(_p_exponent))))(input)?;
    Ok((r_input, ()))
}

/// Recognize a valid number, return "true" or "false" as a string.
#[tracing::instrument]
fn valid_number(input: &str) -> Result<&'static str> {
    debug!("Checking whether '{input}' is a valid number");
    if _p_valid_number(input).is_ok() {
        Ok("true")
    } else {
        Ok("false")
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
        println!(
            "{res}",
            res = valid_number(line.trim_end_matches(&['\r', '\n']))?
        );
    } else {
        for test_str in TEST_NUMBERS {
            println!("{res}", res = valid_number(test_str)?);
        }
    }
    Ok(MainResult::Ok)
}
