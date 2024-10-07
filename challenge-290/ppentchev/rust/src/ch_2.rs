// SPDX-FileCopyrightText: Peter Pentchev <roam@ringlet.net>
// SPDX-License-Identifier: BSD-2-Clause
//! Run Luhn's algorithm to check a checksum digit.

use std::iter::FusedIterator;
use std::str::Chars;

use thiserror::Error;
use tracing::trace;

/// An error that occurred during the scanning of the string.
#[derive(Debug, Error)]
#[non_exhaustive]
#[allow(clippy::error_impl_error)]
pub enum Error {
    /// No digits at all in the input string.
    #[error("No digits at all in the input string")]
    NoDigits,

    /// An unexpected arithmetic overflow occurred.
    #[error("An unexpected arithmetic overflow occurred: {0}")]
    Overflow(String),
}

/// Iterate over a string's characters in reverse, return only the digits.
#[derive(Debug)]
struct DigitsOnly<'data> {
    /// The iterator to grab characters from.
    it: Chars<'data>,

    /// Are we done yet?
    done: bool,
}

impl<'data> DigitsOnly<'data> {
    /// Iterate over the specified string slice.
    pub fn from_str(text: &'data str) -> Self {
        Self {
            it: text.chars(),
            done: false,
        }
    }
}

impl Iterator for DigitsOnly<'_> {
    type Item = u32;

    #[inline]
    #[must_use]
    fn next(&mut self) -> Option<Self::Item> {
        if self.done {
            return None;
        }

        loop {
            if let Some(chr) = self.it.next_back() {
                match chr {
                    '0' => return Some(0),
                    '1' => return Some(1),
                    '2' => return Some(2),
                    '3' => return Some(3),
                    '4' => return Some(4),
                    '5' => return Some(5),
                    '6' => return Some(6),
                    '7' => return Some(7),
                    '8' => return Some(8),
                    '9' => return Some(9),
                    _ => (),
                }
            } else {
                self.done = true;
                return None;
            }
        }
    }
}

impl FusedIterator for DigitsOnly<'_> {}

/// Keep track of the sum as we iterate over the digits.
#[derive(Debug)]
struct LuhnState {
    /// The sum accumulated so far (modulo 100).
    sum: u32,

    /// Whether we should double the next number.
    double: bool,
}

impl Default for LuhnState {
    #[inline]
    #[must_use]
    fn default() -> Self {
        Self {
            sum: 0_u32,
            double: true,
        }
    }
}

impl LuhnState {
    /// Handle a single digit: double it if necessary, add digits if necessary, etc.
    ///
    /// Always keep the sum less than 100 by only keeping its last digit if it goes over.
    ///
    /// # Errors
    ///
    /// [`Error::NoDigits]` if the input string does not contain any digits.
    /// [`Error::Overflow]` on a very much unexpected integer overflow.
    #[inline]
    fn update(self, digit: u32) -> Result<Self, Error> {
        trace!(digit);
        let value = if self.double {
            digit
                .checked_mul(2)
                .ok_or_else(|| Error::Overflow(format!("Could not multiply {digit} by 2")))?
        } else {
            digit
        };

        // Bah, 9 is a special case...
        let to_add = value
            .checked_sub(9)
            .map_or(value, |diff| if diff == 0 { value } else { diff });

        let raw_sum = self.sum.checked_add(to_add).ok_or_else(|| {
            Error::Overflow(format!("Could not add {to_add} to {sum}", sum = self.sum))
        })?;
        let sum = if raw_sum >= 100 {
            raw_sum
                .checked_rem(10)
                .ok_or_else(|| Error::Overflow(format!("Could not divide {raw_sum} by 10")))?
        } else {
            raw_sum
        };
        trace!(sum);

        Ok(Self {
            sum,
            double: !self.double,
        })
    }
}

/// Run Luhn's algorithm to check a checksum digit.
///
/// # Errors
///
/// [`Error::NoDigits]` if the input string does not contain any digits.
/// [`Error::Overflow]` on a very much unexpected integer overflow.
#[inline]
pub fn luhn_check(text: &str) -> Result<bool, Error> {
    trace!(text);
    let mut digits = DigitsOnly::from_str(text);
    let cksum = digits.next().ok_or(Error::NoDigits)?;
    trace!(cksum);
    let sum = digits
        .try_fold(LuhnState::default(), LuhnState::update)?
        .sum;

    let final_sum = sum
        .checked_add(cksum)
        .ok_or_else(|| Error::Overflow(format!("Could not add {cksum} to {sum}")))?;
    Ok(final_sum
        .checked_rem(10)
        .ok_or_else(|| Error::Overflow(format!("Could not divide {final_sum} by 10")))?
        == 0)
}

#[cfg(test)]
#[allow(clippy::print_stdout)]
#[allow(clippy::unwrap_used)]
mod tests {
    use rstest::rstest;
    use tracing_test::traced_test;

    #[rstest]
    #[traced_test]
    #[case("17893729974", true)]
    #[case("4137 8947 1175 5904", true)]
    #[case("4137 8974 1175 5904", false)]
    #[case("00", true)]
    #[case("01", false)]
    #[case("05", false)]
    #[case("18", true)]
    #[case("19", false)]
    #[case("11", false)]
    #[case("59", true)]
    #[case("50", false)]
    #[case("67", true)]
    #[case("66", false)]
    #[case(" ?23a#2 :)", true)]
    #[case(" ?32a#2 :)", false)]
    #[case("a0b1c2d3e4f5g6h7i8j9k0", false)]
    #[case("a0b1c2d3e4f5g6h7i8j9k1", false)]
    #[case("a0b1c2d3e4f5g6h7i8j9k2", false)]
    #[case("a0b1c2d3e4f5g6h7i8j9k3", false)]
    #[case("a0b1c2d3e4f5g6h7i8j9k4", false)]
    #[case("a0b1c2d3e4f5g6h7i8j9k5", false)]
    #[case("a0b1c2d3e4f5g6h7i8j9k6", false)]
    #[case("a0b1c2d3e4f5g6h7i8j9k7", true)]
    #[case("a0b1c2d3e4f5g6h7i8j9k8", false)]
    #[case("a0b1c2d3e4f5g6h7i8j9k9", false)]
    fn test_luhn_check(#[case] text: &str, #[case] expected: bool) {
        println!();
        assert_eq!(expected, super::luhn_check(text).unwrap());
    }
}
