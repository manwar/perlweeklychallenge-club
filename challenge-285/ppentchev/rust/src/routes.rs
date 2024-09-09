// SPDX-FileCopyrightText: Peter Pentchev <roam@ringlet.net>
// SPDX-License-Identifier: BSD-2-Clause
//! Solve the first task for week 285, "No Connection".

use std::collections::HashSet;

use tracing::{debug, trace};

use crate::defs::Error;

/// Week 285 task 1: No Connection.
///
/// # Errors
///
/// [`Error::NotImplemented`] so far.
#[tracing::instrument(skip(routes))]
#[inline]
pub fn solve_no_connection(routes: &[(String, String)]) -> Result<String, Error> {
    debug!(
        "About to look for a leaf destination in {count} routes",
        count = routes.len()
    );
    let (set_from, set_to) = routes.iter().fold(
        (HashSet::new(), HashSet::new()),
        |(mut set_from, mut set_to): (HashSet<&str>, HashSet<&str>),
         &(ref route_from, ref route_to)| {
            set_from.insert(route_from.as_ref());
            set_to.insert(route_to.as_ref());
            (set_from, set_to)
        },
    );
    trace!("from: {count}", count = set_from.len());
    trace!("to: {count}", count = set_to.len());

    let mut diff = set_to.difference(&set_from);
    let first = diff
        .next()
        .ok_or_else(|| Error::NoSolution("Not even a single leaf destination".to_owned()))?;
    trace!(first);
    diff.next().map_or_else(
        || Ok((*first).to_owned()),
        |second| {
            trace!(second);
            Err(Error::NoSolution(
                "More than one leaf destination".to_owned(),
            ))
        },
    )
}
