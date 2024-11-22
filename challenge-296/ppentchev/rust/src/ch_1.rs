// SPDX-FileCopyrightText: Peter Pentchev <roam@ringlet.net>
// SPDX-License-Identifier: BSD-2-Clause
//! String Compression - run-length encoding.

/// Compress a string... somewhat.
#[inline]
#[must_use]
pub fn rle_compress(chars: &str) -> String {
    let (mut res, last_opt) =
        chars
            .chars()
            .fold((String::new(), None), |(mut res, last_opt), chr| {
                if let Some((last_chr, count)) = last_opt {
                    if chr == last_chr {
                        #[allow(clippy::arithmetic_side_effects)]
                        (res, Some((last_chr, count + 1)))
                    } else {
                        if count == 1_usize {
                            res.push(last_chr);
                        } else {
                            res = format!("{res}{count}{last_chr}");
                        }
                        (res, Some((chr, 1_usize)))
                    }
                } else {
                    (res, Some((chr, 1_usize)))
                }
            });

    if let Some((last_chr, count)) = last_opt {
        if count == 1_usize {
            res.push(last_chr);
        } else {
            res = format!("{res}{count}{last_chr}");
        }
    }
    res
}

/// Decompress a somewhat compressed string.
#[inline]
#[must_use]
pub fn rle_decompress(chars: &str) -> String {
    chars
        .chars()
        .fold((String::new(), None), |(mut res, last_opt), chr| {
            if let Some(digit) = chr.to_digit(10) {
                if let Some(num) = last_opt {
                    #[allow(clippy::arithmetic_side_effects)]
                    (res, Some(num * 10 + digit))
                } else {
                    (res, Some(digit))
                }
            } else {
                for _ in 0..last_opt.unwrap_or(1) {
                    res.push(chr);
                }
                (res, None)
            }
        })
        .0
}

#[cfg(test)]
#[allow(clippy::print_stdout)]
mod tests {
    use rstest::rstest;

    #[rstest]
    #[case("abbc", "a2bc")]
    #[case("aaabccc", "3ab3c")]
    #[case("abcc", "ab2c")]
    fn test_compress(#[case] chars: &str, #[case] expected: &str) {
        println!();
        assert_eq!(super::rle_compress(chars), expected);
    }

    #[rstest]
    #[case("abbc", "a2bc")]
    #[case("aaabccc", "3ab3c")]
    #[case("abcc", "ab2c")]
    fn test_decompress(#[case] chars: &str, #[case] expected: &str) {
        println!();
        assert_eq!(super::rle_decompress(expected), chars);
    }
}
