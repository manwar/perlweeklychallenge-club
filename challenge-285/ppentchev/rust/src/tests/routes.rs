// SPDX-FileCopyrightText: Peter Pentchev <roam@ringlet.net>
// SPDX-License-Identifier: BSD-2-Clause
//! Test the first task for week 285, "No Connection".

use anyhow::{bail, Context, Result};
use rstest::rstest;
use tracing_test::traced_test;

use crate::defs::Error;
use crate::routes;

/// Check whether the first task solver works.
#[traced_test]
#[rstest]
#[case(
    &[
        ("me".to_owned(), "you".to_owned()),
    ],
    "you",
)]
#[case(
    &[
        ("here".to_owned(), "there".to_owned()),
        ("here".to_owned(), "everywhere".to_owned()),
        ("there".to_owned(), "everywhere".to_owned()),
    ],
    "everywhere",
)]
#[case(
    &[("B".to_owned(), "C".to_owned()), ("D".to_owned(), "B".to_owned()), ("C".to_owned(), "A".to_owned())],
    "A",
)]
#[case(&[("A".to_owned(), "Z".to_owned())], "Z")]
fn test_connection(#[case] routes: &[(String, String)], #[case] expected: &str) -> Result<()> {
    println!();
    let found = routes::solve_no_connection(routes).context("Could not solve 285/1")?;
    assert_eq!(found, expected);
    Ok(())
}

/// Check whether the first task solver reports errors as expected.
#[traced_test]
#[rstest]
#[case(&[])]
#[case(&[
    ("here".to_owned(), "there".to_owned()),
    ("here".to_owned(), "everywhere".to_owned()),
])]
#[case(&[
    ("me".to_owned(), "you".to_owned()),
    ("you".to_owned(), "me".to_owned()),
])]
fn test_no_connection(#[case] routes: &[(String, String)]) -> Result<()> {
    println!();
    match routes::solve_no_connection(routes) {
        Ok(res) => bail!("Unexpected success: {res:?}"),
        Err(Error::NoSolution(_)) => Ok(()),
        Err(err) => Err(err).context("Unexpected error"),
    }
}
