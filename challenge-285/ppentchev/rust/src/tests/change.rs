// SPDX-FileCopyrightText: Peter Pentchev <roam@ringlet.net>
// SPDX-License-Identifier: BSD-2-Clause
//! Test the second for week 285, "Making Change".

use anyhow::Result;
use rstest::rstest;
use tracing_test::traced_test;

use crate::change::{self, Coin};

/// Check whether we know how to recurse into breaking amounts of money down.
#[traced_test]
#[rstest]
#[case(1, Coin::HalfDollar, &[])]
#[case(2, Coin::HalfDollar, &[])]
#[case(6, Coin::HalfDollar, &[(1_u32, Coin::Penny)])]
#[case(6, Coin::Nickel, &[(1_u32, Coin::Penny)])]
#[case(6, Coin::Penny, &[])]
#[case(7, Coin::HalfDollar, &[(2_u32, Coin::Penny)])]
#[case(7, Coin::Nickel, &[(2_u32, Coin::Penny)])]
#[case(7, Coin::Penny, &[])]
#[case(10, Coin::HalfDollar, &[(0_u32, Coin::Nickel), (5_u32, Coin::Penny), (0_u32, Coin::Penny)])]
#[case(10, Coin::Dime, &[(0_u32, Coin::Nickel), (5_u32, Coin::Penny), (0_u32, Coin::Penny)])]
#[case(10, Coin::Nickel, &[(5_u32, Coin::Penny), (0_u32, Coin::Penny)])]
#[case(10, Coin::Penny, &[])]
#[case(12, Coin::HalfDollar, &[(2_u32, Coin::Nickel), (7_u32, Coin::Penny), (2_u32, Coin::Penny)])]
#[case(12, Coin::Dime, &[(2_u32, Coin::Nickel), (7_u32, Coin::Penny), (2_u32, Coin::Penny)])]
#[case(12, Coin::Nickel, &[(7_u32, Coin::Penny), (2_u32, Coin::Penny)])]
#[case(12, Coin::Penny, &[])]
#[case(15, Coin::HalfDollar, &[(5_u32, Coin::Nickel), (10_u32, Coin::Penny), (5_u32, Coin::Penny), (0_u32, Coin::Penny)])]
#[case(15, Coin::Dime, &[(5_u32, Coin::Nickel), (10_u32, Coin::Penny), (5_u32, Coin::Penny), (0_u32, Coin::Penny)])]
#[case(15, Coin::Nickel, &[(10_u32, Coin::Penny), (5_u32, Coin::Penny), (0_u32, Coin::Penny)])]
#[case(15, Coin::Penny, &[])]
fn test_break_down_ways(
    #[case] amount: u32,
    #[case] highest: Coin,
    #[case] expected: &[(u32, Coin)],
) -> Result<()> {
    assert_eq!(change::break_down_ways(amount, highest)?, expected);
    Ok(())
}

/// Check whether we can calculate the number of ways money can be broken down.
#[traced_test]
#[rstest]
#[case(9, 2)]
#[case(15, 6)]
#[case(100, 292)]
fn test_making_change(#[case] amount: u32, #[case] expected: u32) -> Result<()> {
    assert_eq!(change::solve_making_change(amount)?, expected);
    Ok(())
}
