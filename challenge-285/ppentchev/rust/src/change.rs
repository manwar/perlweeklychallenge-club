// SPDX-FileCopyrightText: Peter Pentchev <roam@ringlet.net>
// SPDX-License-Identifier: BSD-2-Clause
//! Solve the second for week 285, "Making Change".

use std::collections::HashMap;
use std::fmt::{Display, Formatter, Result as FmtResult};

use anyhow::{anyhow, Context};
use itertools::Itertools;
use tracing::{debug, trace};

use crate::defs::Error;

/// The coin denominations.
#[derive(Debug, Clone, Copy, PartialEq, Eq, PartialOrd, Ord, Hash)]
#[allow(clippy::exhaustive_enums)]
pub enum Coin {
    /// A penny (1c).
    Penny,

    /// A nickel (5c).
    Nickel,

    /// A dime (10c).
    Dime,

    /// A quarter (25c).
    Quarter,

    /// A half-dollar (50c).
    HalfDollar,
}

impl Coin {
    /// The coin denominations from highest to lowest, except for the penny.
    ///
    /// The penny is excluded because we don't want to return it in the recursive
    /// breakdown processing.
    const ORDER_ABP: [Self; 4] = [Self::HalfDollar, Self::Quarter, Self::Dime, Self::Nickel];

    /// The name of a penny.
    pub const PENNY: &'static str = "penny";

    /// The name of a nickel.
    pub const NICKEL: &'static str = "nickel";

    /// The name of a dime.
    pub const DIME: &'static str = "dime";

    /// The name of a quarter.
    pub const QUARTER: &'static str = "quarter";

    /// The name of a half dollar.
    pub const HALF_DOLLAR: &'static str = "half dollar";

    /// The numeric value of a coin.
    #[inline]
    #[must_use]
    pub const fn value(&self) -> u32 {
        match *self {
            Self::Penny => 1,
            Self::Nickel => 5,
            Self::Dime => 10,
            Self::Quarter => 25,
            Self::HalfDollar => 50,
        }
    }

    /// The next step down.
    ///
    /// # Errors
    ///
    /// [`Error::InternalError`] if this is invoked for [`Coin::Penny`].
    #[inline]
    pub fn lower(&self) -> Result<Self, Error> {
        match *self {
            Self::Penny => Err(Error::InternalError(anyhow!(
                "Coin::lower() should never be asked about a penny"
            ))),
            Self::Nickel => Ok(Self::Penny),
            Self::Dime => Ok(Self::Nickel),
            Self::Quarter => Ok(Self::Dime),
            Self::HalfDollar => Ok(Self::Quarter),
        }
    }
}

impl AsRef<str> for Coin {
    #[inline]
    fn as_ref(&self) -> &str {
        match *self {
            Self::Penny => Self::PENNY,
            Self::Nickel => Self::NICKEL,
            Self::Dime => Self::DIME,
            Self::Quarter => Self::QUARTER,
            Self::HalfDollar => Self::HALF_DOLLAR,
        }
    }
}

impl Display for Coin {
    #[inline]
    #[allow(clippy::min_ident_chars)]
    fn fmt(&self, f: &mut Formatter<'_>) -> FmtResult {
        write!(f, "{value}", value = self.as_ref())
    }
}

/// Prepare to recurse into breaking an amount of money down into parts.
///
/// Return the different ways of breaking down into smaller coins except for pennies-only.
#[tracing::instrument]
pub fn break_down_ways(amount: u32, highest: Coin) -> Result<Vec<(u32, Coin)>, Error> {
    Coin::ORDER_ABP
        .iter()
        .filter(|coin| **coin <= highest)
        .map(|coin| -> Result<Vec<(u32, Coin)>, Error> {
            trace!(?coin);
            let value = coin.value();
            trace!(value);
            let lower = coin.lower()?;
            trace!(?lower);
            let step = usize::try_from(value)
                .with_context(|| format!("Could not convert {value} to usize"))
                .map_err(Error::InternalError)?;
            Ok((value..)
                .step_by(step)
                .map_while(|used| amount.checked_sub(used).map(|rem| (rem, lower)))
                .collect())
        })
        .flatten_ok()
        .collect::<Result<_, _>>()
}

/// Figure out whether the set of parameters trivially resolves to a single solution.
fn trivial(amount: u32, highest: Coin) -> bool {
    highest == Coin::Penny || amount == 0
}

/// Recurse into breaking an amount of money down into parts.
///
/// Count the different ways of breaking down into smaller coins, pennies-only included.
#[tracing::instrument]
pub fn make_change_rec(
    amount: u32,
    highest: Coin,
    cache: &mut HashMap<(u32, Coin), u32>,
) -> Result<u32, Error> {
    if trivial(amount, highest) {
        return Ok(1);
    }
    if let Some(seen) = cache.get(&(amount, highest)) {
        return Ok(*seen);
    }

    let ways = break_down_ways(amount, highest)?;
    trace!(?ways);
    let (sum, upd_cache) = ways.into_iter().try_fold(
        (1_u32, cache),
        |(sum, current_cache), (b_amount, b_highest)| {
            let current = if trivial(b_amount, b_highest) {
                1_u32
            } else {
                make_change_rec(b_amount, b_highest, current_cache)?
            };

            let upd_sum = sum
                .checked_add(current)
                .ok_or_else(|| Error::InternalError(anyhow!("Could not add {current} to {sum}")))?;
            Ok((upd_sum, current_cache))
        },
    )?;
    trace!(sum);
    upd_cache.insert((amount, highest), sum);
    Ok(sum)
}

/// Week 285 task 2: Making Change.
///
/// # Errors
///
/// [`Error::NotImplemented`] so far.
#[tracing::instrument]
#[inline]
pub fn solve_making_change(amount: u32) -> Result<u32, Error> {
    debug!("About to break {amount} cents down");
    make_change_rec(amount, Coin::HalfDollar, &mut HashMap::new())
}
