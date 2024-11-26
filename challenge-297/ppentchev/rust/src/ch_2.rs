// SPDX-FileCopyrightText: Peter Pentchev <roam@ringlet.net>
// SPDX-License-Identifier: BSD-2-Clause
//! Semi-ordered Permutation - count the exchanges.

use thiserror::Error;
use tracing::trace;

/// Something went wrong during the calculations.
#[derive(Debug, Error)]
#[non_exhaustive]
#[allow(clippy::error_impl_error)]
pub enum Error {
    /// Unexpectedly unable to add stuff.
    #[error("Unexpected arithmetic overflow")]
    ArithmeticOverflow,

    /// Either 1 or n was either not found or found more than once.
    #[error("The input sequence must contain both 1 and {0} exactly once")]
    NotOnce(usize),
}

/// Determine the smallest number of exchanges towards a semi-ordered permutation.
///
/// # Errors
///
/// [`Error::NotOnce`] if either 1 or n occurs either zero or more than one time.
/// [`Error::ArithmeticOverflow`] on really unexpected overflows.
pub fn semi_ordered(ints: &[usize]) -> Result<usize, Error> {
    trace!(?ints);
    match ints.split_first() {
        None | Some((&1, &[])) => return Ok(0),
        Some((_, &[])) => return Err(Error::NotOnce(1)),
        _ => (),
    };
    let len = ints.len();

    let (opt_1, opt_n) = ints.iter().enumerate().try_fold(
        (None, None),
        |(opt_1, opt_n): (Option<usize>, Option<usize>),
         (idx, value): (usize, &usize)|
         -> Result<(Option<usize>, Option<usize>), Error> {
            if *value == 1 {
                if opt_1.is_none() {
                    Ok((Some(idx), opt_n))
                } else {
                    Err(Error::NotOnce(len))
                }
            } else if *value == len {
                if opt_n.is_none() {
                    Ok((opt_1, Some(idx)))
                } else {
                    Err(Error::NotOnce(len))
                }
            } else {
                Ok((opt_1, opt_n))
            }
        },
    )?;
    let pos_1 = opt_1.ok_or(Error::NotOnce(len))?;
    trace!(pos_1);
    let pos_n = opt_n.ok_or(Error::NotOnce(len))?;
    trace!(pos_n);
    let n_needed = len
        .checked_sub(pos_n)
        .ok_or(Error::ArithmeticOverflow)?
        .checked_sub(1)
        .ok_or(Error::ArithmeticOverflow)?;
    trace!(n_needed);
    if pos_1 > pos_n {
        pos_1
            .checked_sub(1)
            .ok_or(Error::ArithmeticOverflow)?
            .checked_add(n_needed)
            .ok_or(Error::ArithmeticOverflow)
    } else {
        pos_1.checked_add(n_needed).ok_or(Error::ArithmeticOverflow)
    }
}

#[cfg(test)]
#[allow(clippy::panic_in_result_fn)]
#[allow(clippy::print_stdout)]
mod tests {
    use rstest::rstest;
    use tracing_test::traced_test;

    use super::Error;

    #[rstest]
    #[case(&[2, 1, 4, 3], 2)]
    #[case(&[2, 4, 1, 3], 3)]
    #[case(&[1, 3, 2, 4, 5], 0)]
    #[traced_test]
    fn test_semi_ordered(#[case] ints: &[usize], #[case] expected: usize) -> Result<(), Error> {
        println!();
        assert_eq!(super::semi_ordered(ints)?, expected);
        Ok(())
    }
}
