// SPDX-FileCopyrightText: Peter Pentchev <roam@ringlet.net>
// SPDX-License-Identifier: BSD-2-Clause
//! Matchstick Square - can we make a square?

use std::iter;

use tracing::trace;

/// Really determine whether we can build the sought stuff out of that.
#[allow(clippy::indexing_slicing)]
fn match_sides(sought: &[u32], needle: u32, sticks: &[u32], used: &mut Vec<bool>) -> bool {
    trace!(?sought);
    trace!(needle);
    trace!(?used);
    sticks.iter().enumerate().any(|(idx, &stick)| {
        if used[idx] {
            return false;
        }

        needle.checked_sub(stick).map_or(false, |left| {
            trace!(idx);
            used[idx] = true;
            let res = if left == 0 {
                match sought.split_first() {
                    Some((next_needle, rest_sought)) => {
                        match_sides(rest_sought, *next_needle, sticks, used)
                    }
                    None => true,
                }
            } else {
                match_sides(sought, left, sticks, used)
            };
            used[idx] = false;
            trace!(res);
            res
        })
    })
}

/// Determine whether we can build a square out of the specified sticks.
pub fn matchstick_square(ints: &[u32]) -> bool {
    trace!(?ints);
    let int_sum: u32 = ints.iter().sum();
    if int_sum & 0x03 != 0 {
        return false;
    }
    let side = int_sum >> 2_usize;

    let sorted = {
        let mut sorted = ints.to_vec();
        sorted.sort_unstable();
        sorted.reverse();
        sorted
    };
    match sorted.first() {
        Some(longest) if *longest > side => return false,
        Some(_) => (),
        None => return false,
    };
    let mut used: Vec<_> = iter::repeat(false).take(sorted.len()).collect();
    match_sides(&[side, side, side], side, &sorted, &mut used)
}

#[cfg(test)]
#[allow(clippy::print_stdout)]
mod tests {
    use rstest::rstest;
    use tracing_test::traced_test;

    #[rstest]
    #[case(&[3], false)]
    #[case(&[3, 3], false)]
    #[case(&[3, 3, 3], false)]
    #[case(&[3, 3, 3, 3], true)]
    #[case(&[3, 3, 3, 4], false)]
    #[case(&[4], false)]
    #[case(&[4, 4], false)]
    #[case(&[4, 4, 4], false)]
    #[case(&[4, 4, 4, 4], true)]
    #[case(&[4, 4, 4, 5], false)]
    #[case(&[1, 2, 2, 2, 1], true)]
    #[case(&[2, 2, 2, 4], false)]
    #[case(&[2, 2, 2, 2, 4], false)]
    #[case(&[3, 4, 1, 4, 3, 1], true)]
    #[traced_test]
    fn test_matchsticks(#[case] ints: &[u32], #[case] expected: bool) {
        println!();
        assert_eq!(super::matchstick_square(ints), expected);
    }
}
