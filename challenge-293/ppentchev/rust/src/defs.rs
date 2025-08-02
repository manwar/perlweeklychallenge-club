// SPDX-FileCopyrightText: Peter Pentchev <roam@ringlet.net>
// SPDX-License-Identifier: BSD-2-Clause
//! Common definitions for Peter Pentchev's solutions to PWC 293.

use thiserror::Error;

/// An error that occurred while processing the input data.
#[derive(Debug, Error)]
#[non_exhaustive]
#[allow(clippy::error_impl_error)]
pub enum Error {
    /// Did we really overflow the usize type?
    #[error("Did we really overflow the usize or u64 type?!")]
    ArithmeticOverflow,

    /// Something went really, really wrong...
    #[error("similar-dominos internal error: {0}")]
    Internal(String),
}
