// SPDX-FileCopyrightText: Peter Pentchev <roam@ringlet.net>
// SPDX-License-Identifier: BSD-2-Clause
//! Contiguous Array - an equal number of zeroes and ones.

use thiserror::Error;
use tracing::trace;

/// An error that occurred during the array processing.
#[derive(Debug, Error)]
#[non_exhaustive]
#[allow(clippy::error_impl_error)]
pub enum Error {
    /// An unexpected arithmetic overflow error.
    #[error("Could not update {0:?} with '{1}'")]
    Add(Count, bool),

    /// An unexpected value was found in the array.
    #[error("Not a zero or one: {0}")]
    BadValue(u32),

    /// Something went really, really wrong.
    #[error("Internal error: {0}")]
    Internal(String),
}

/// Keep track of how many zeroes and ones we have found.
#[derive(Debug, Clone, Copy)]
pub struct Count(usize, usize);

impl Count {
    /// Construct a [`Count`] object.
    #[inline]
    #[must_use]
    const fn new() -> Self {
        Self(0, 0)
    }

    /// Update the count according to the current digit.
    #[inline]
    fn update(&mut self, current: bool) -> Result<(), Error> {
        if current {
            self.1 = self.1.checked_add(1).ok_or(Error::Add(*self, current))?;
        } else {
            self.0 = self.0.checked_add(1).ok_or(Error::Add(*self, current))?;
        }
        Ok(())
    }

    /// Check whether balance has been achieved.
    #[inline]
    #[must_use]
    const fn is_cool(&self) -> bool {
        self.0 == self.1
    }
}

/// Look for something in an array.
///
/// # Errors
///
/// [`Error::BadValue`] if something other than a 0 or 1 is encountered in the input data.
/// [`Error::Add`] if something goes wrong during the calculations.
#[inline]
pub fn contig(binary: &[u32]) -> Result<usize, Error> {
    let res = binary.iter().try_fold(
        (vec![], Count::new(), 0),
        |(mut counts, mut acc, mut best): (Vec<Count>, Count, usize),
         current: &u32|
         -> Result<(Vec<Count>, Count, usize), Error> {
            trace!(?counts);
            trace!(?acc);
            trace!(best);
            trace!(current);
            let is_one = match *current {
                0 => false,
                1 => true,
                other => return Err(Error::BadValue(other)),
            };

            let counts_len = counts.len();
            for (count, distance) in counts.iter_mut().zip((0..counts_len).rev()) {
                trace!(?count);
                trace!(distance);
                count.update(is_one)?;
                if count.is_cool() && best < distance {
                    trace!("balanced at {distance}");
                    best = distance;
                }
            }

            acc.update(is_one)?;
            trace!(?acc);
            counts.push(acc);
            if acc.is_cool() {
                trace!("balanced at end");
                best = counts.len();
            }
            Ok((counts, acc, best))
        },
    )?;
    Ok(res.2)
}

#[cfg(test)]
#[allow(clippy::panic_in_result_fn)]
#[allow(clippy::print_stdout)]
mod tests {
    use rstest::rstest;
    use tracing_test::traced_test;

    use super::Error;

    #[rstest]
    #[case(&[1, 0], 2)]
    #[case(&[0, 1, 0], 2)]
    #[case(&[0, 0, 0, 0, 0], 0)]
    #[case(&[0, 1, 0, 1, 0], 4)]
    #[traced_test]
    fn test_contig(#[case] binary: &[u32], #[case] expected: usize) -> Result<(), Error> {
        println!();
        assert_eq!(super::contig(binary)?, expected);
        Ok(())
    }
}
