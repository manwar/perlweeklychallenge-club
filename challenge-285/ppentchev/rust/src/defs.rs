// SPDX-FileCopyrightText: Peter Pentchev <roam@ringlet.net>
// SPDX-License-Identifier: BSD-2-Clause
//! Common definitions for the `perl-weekly` crate.

use anyhow::Error as AnyError;
use thiserror::Error;

/// An error that occurred during the doing of things.
#[derive(Debug, Error)]
#[non_exhaustive]
#[allow(clippy::error_impl_error)]
pub enum Error {
    /// Something went really, really wrong.
    #[error("fnmatch-regex internal error")]
    InternalError(#[source] AnyError),

    /// Either no solution or too many solutions or something else.
    #[error("No solution found: {0}")]
    NoSolution(String),

    /// Some known missing functionality.
    #[error("Not implemented yet: {0}")]
    NotImplemented(String),
}
