// SPDX-FileCopyrightText: Peter Pentchev <roam@ringlet.net>
// SPDX-License-Identifier: BSD-2-Clause
//! Boomerang - check whether three points on the Cartesian plane are colinear

use crate::defs::Error;

/// Check whether three points form a boomerang, i.e. are not colinear.
///
/// # Errors
///
/// [`Error::ArithmeticOverflow`] in a practically impossible case.
#[inline]
pub fn boomerang(points: &[(i32, i32); 3]) -> Result<bool, Error> {
    let sorted = {
        let mut sorted = *points;
        sorted.sort_unstable();
        sorted
    };
    let diff_a = (
        sorted[0].0.abs_diff(sorted[1].0),
        sorted[0].1.abs_diff(sorted[1].1),
    );
    let diff_b = (
        sorted[1].0.abs_diff(sorted[2].0),
        sorted[1].1.abs_diff(sorted[2].1),
    );
    let (first, second) = if diff_a < diff_b {
        (diff_a, diff_b)
    } else {
        (diff_b, diff_a)
    };

    // Semantically, "two points are the same" is not the same as "some points are on the same line".
    #[allow(clippy::match_same_arms)]
    match (first, second) {
        // Are any two points the same?
        ((0, 0), _) => Ok(false),

        // Are the three points on the same horizontal or vertical line?
        ((0, _), (0, _)) | ((_, 0), (_, 0)) => Ok(false),

        // Are two points, but not the third one, on the same horizontal or vertical line?
        ((0, _) | (_, 0), _) | (_, (0, _) | (_, 0)) => Ok(true),

        _ => {
            // Right, so we have to actually do some work here...
            // Unfortunately, `u32::carrying_mul` and `u32::widening_mul` are still unstable
            // as of Rust 1.82.
            let (first_u64, second_u64): ((u64, u64), (u64, u64)) = (
                (first.0.into(), first.1.into()),
                (second.0.into(), second.1.into()),
            );
            let product_a = first_u64
                .0
                .checked_mul(second_u64.1)
                .ok_or(Error::ArithmeticOverflow)?;
            let product_b = first_u64
                .1
                .checked_mul(second_u64.0)
                .ok_or(Error::ArithmeticOverflow)?;
            Ok(product_a != product_b)
        }
    }
}

#[cfg(test)]
#[allow(clippy::panic_in_result_fn)]
mod tests {
    use rstest::rstest;

    use crate::defs::Error;

    #[rstest]
    #[case([(3_i32, 3_i32), (3_i32, 3_i32), (3_i32, 3_i32)], false)]
    #[case([(3_i32, 3_i32), (3_i32, 3_i32), (4_i32, 5_i32)], false)]
    #[case([(4_i32, 5_i32), (3_i32, 3_i32), (3_i32, 3_i32)], false)]
    #[case([(3_i32, 3_i32), (3_i32, 4_i32), (3_i32, 5_i32)], false)]
    #[case([(3_i32, 5_i32), (3_i32, 4_i32), (3_i32, 3_i32)], false)]
    #[case([(3_i32, 3_i32), (4_i32, 3_i32), (5_i32, 3_i32)], false)]
    #[case([(5_i32, 3_i32), (4_i32, 3_i32), (3_i32, 3_i32)], false)]
    #[case([(3_i32, 3_i32), (3_i32, 4_i32), (4_i32, 5_i32)], true)]
    #[case([(4_i32, 5_i32), (3_i32, 4_i32), (3_i32, 3_i32)], true)]
    #[case([(-3_i32, 3_i32), (0_i32, 0_i32), (6_i32, -6_i32)], false)]
    #[case([(-3_i32, 3_i32), (0_i32, 1_i32), (6_i32, -6_i32)], true)]
    #[case([(1_i32, 1_i32), (2_i32, 3_i32), (3_i32, 2_i32)], true)]
    #[case([(1_i32, 1_i32), (2_i32, 2_i32), (3_i32, 3_i32)], false)]
    #[case([(1_i32, 1_i32), (1_i32, 2_i32), (2_i32, 3_i32)], true)]
    #[case([(1_i32, 1_i32), (1_i32, 2_i32), (1_i32, 3_i32)], false)]
    #[case([(1_i32, 1_i32), (2_i32, 1_i32), (3_i32, 1_i32)], false)]
    #[case([(0_i32, 0_i32), (2_i32, 3_i32), (4_i32, 5_i32)], true)]
    fn test_boomerang(
        #[case] points: [(i32, i32); 3],
        #[case] expected: bool,
    ) -> Result<(), Error> {
        assert_eq!(super::boomerang(&points)?, expected);
        Ok(())
    }
}
