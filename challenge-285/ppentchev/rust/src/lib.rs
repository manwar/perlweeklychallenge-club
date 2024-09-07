// SPDX-FileCopyrightText: Peter Pentchev <roam@ringlet.net>
// SPDX-License-Identifier: BSD-2-Clause

#![deny(missing_docs)]
#![deny(clippy::missing_docs_in_private_items)]
//! Solve the tasks in Perl weekly challenge 285.

#![allow(clippy::needless_borrowed_reference)]

pub mod change;
pub mod defs;
pub mod routes;

#[cfg(test)]
mod tests;
