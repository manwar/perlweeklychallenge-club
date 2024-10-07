// SPDX-FileCopyrightText: Peter Pentchev <roam@ringlet.net>
// SPDX-License-Identifier: BSD-2-Clause
//! Figure out whether a list contains at least one double-pair.

use std::collections::HashSet;

use itertools::{FoldWhile, Itertools};

/// Figure out whether a list contains at least one double-pair.
#[inline]
#[must_use]
pub fn doubles_exist(seq: &[u32]) -> bool {
    let res = seq.iter().fold_while(HashSet::new(), |mut seen, value| {
        if let Some(double) = value.checked_mul(2) {
            if seen.contains(&double) {
                return FoldWhile::Done(HashSet::new());
            }
        }

        if (value & 1) == 0 && seen.contains(&(value >> 1_usize)) {
            return FoldWhile::Done(HashSet::new());
        }

        seen.insert(value);
        FoldWhile::Continue(seen)
    });
    matches!(res, FoldWhile::Done(_))
}

#[cfg(test)]
mod tests {
    use rstest::rstest;

    #[rstest]
    #[case(&[6, 2, 2, 3], true)]
    #[case(&[3, 1, 4, 13], false)]
    #[case(&[2, 1, 4, 2], true)]
    #[case(&[], false)]
    #[case(&[0], false)]
    #[case(&[0, 0], true)]
    #[case(&[0, 1], false)]
    #[case(&[1, 0, 0], true)]
    #[case(&[2, 0, 1], true)]
    #[case(&[1, 2, 3, 4], true)]
    #[case(&[1, 2, 3, 5], true)]
    #[case(&[1, 3, 4, 5], false)]
    #[case(&[1, 4], false)]
    #[case(&[1, 2, 4], true)]
    fn test_doubles_exist(#[case] seq: &[u32], #[case] expected: bool) {
        assert_eq!(expected, super::doubles_exist(seq));
    }
}
