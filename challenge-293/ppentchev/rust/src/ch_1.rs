// SPDX-FileCopyrightText: Peter Pentchev <roam@ringlet.net>
// SPDX-License-Identifier: BSD-2-Clause
//! Similar Dominos - count the tiles that resemble others.

use std::collections::hash_map::Entry;
use std::collections::HashMap;

use crate::defs::Error;

/// A single domino tile.
pub type Tile = (u32, u32);

/// Return a tile with the lower number first.
const fn order_tile(tile: Tile) -> Tile {
    if tile.0 > tile.1 {
        (tile.1, tile.0)
    } else {
        (tile.0, tile.1)
    }
}

/// Count the tiles that resemble others.
///
/// # Panics
///
/// On arithmetic overflow when counting tiles.
/// This cannot really happen though, can it?
#[inline]
#[must_use]
pub fn similar_dominos_unchecked(tiles: &[Tile]) -> usize {
    // There's nothing we can do, and `.sum()` will panic anyway...
    #[allow(clippy::arithmetic_side_effects)]
    tiles
        .iter()
        .map(|tile| order_tile(*tile))
        .fold(HashMap::<Tile, usize>::new(), |mut acc, tile| {
            acc.entry(tile).and_modify(|count| *count += 1).or_insert(1);
            acc
        })
        .into_values()
        .filter(|count| *count > 1)
        .sum()
}

/// Count the tiles that resemble others, but more reliably.
///
/// # Errors
///
/// [`Error::ArithmeticOverflow`] in a really, really unlikely case.
#[inline]
pub fn similar_dominos(tiles: &[Tile]) -> Result<usize, Error> {
    tiles
        .iter()
        .map(|tile| order_tile(*tile))
        .try_fold(HashMap::<Tile, usize>::new(), |mut acc, tile| {
            match acc.entry(tile) {
                Entry::Occupied(occ) => {
                    let value = occ.into_mut();
                    *value = (*value).checked_add(1).ok_or(Error::ArithmeticOverflow)?;
                }
                Entry::Vacant(vac) => {
                    vac.insert(1);
                }
            };
            Ok(acc)
        })?
        .into_values()
        .try_fold(0_usize, |acc, value| {
            if value > 1 {
                acc.checked_add(value).ok_or(Error::ArithmeticOverflow)
            } else {
                Ok(acc)
            }
        })
}

#[cfg(test)]
#[allow(clippy::panic_in_result_fn)]
mod test {
    use rstest::rstest;

    use crate::defs::Error;

    use super::Tile;

    #[rstest]
    #[case(&[], 0)]
    #[case(&[(1, 1)], 0)]
    #[case(&[(1, 2)], 0)]
    #[case(&[(1, 1), (1, 1)], 2)]
    #[case(&[(1, 1), (1, 2)], 0)]
    #[case(&[(1, 2), (2, 1)], 2)]
    #[case(&[(1, 1), (1, 1), (1, 1)], 3)]
    #[case(&[(1, 3), (3, 1), (1, 3)], 3)]
    #[case(&[(1, 1), (1, 3), (2, 3), (3, 1)], 2)]
    #[case(&[(1, 3), (3, 1), (2, 4), (6, 8)], 2)]
    fn test_similar_dominos_unchecked(#[case] tiles: &[Tile], #[case] expected: usize) {
        assert_eq!(super::similar_dominos_unchecked(tiles), expected);
    }

    #[rstest]
    #[case(&[], 0)]
    #[case(&[(1, 1)], 0)]
    #[case(&[(1, 2)], 0)]
    #[case(&[(1, 1), (1, 1)], 2)]
    #[case(&[(1, 1), (1, 2)], 0)]
    #[case(&[(1, 2), (2, 1)], 2)]
    #[case(&[(1, 1), (1, 1), (1, 1)], 3)]
    #[case(&[(1, 3), (3, 1), (1, 3)], 3)]
    #[case(&[(1, 1), (1, 3), (2, 3), (3, 1)], 2)]
    #[case(&[(1, 3), (3, 1), (2, 4), (6, 8)], 2)]
    fn test_similar_dominos(#[case] tiles: &[Tile], #[case] expected: usize) -> Result<(), Error> {
        assert_eq!(super::similar_dominos(tiles)?, expected);
        Ok(())
    }
}
