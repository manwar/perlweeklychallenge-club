<!--
SPDX-FileCopyrightText: Peter Pentchev <roam@ringlet.net>
SPDX-License-Identifier: BSD-2-Clause
-->

# Hey, that one looks just like me!

## PWC 293

[This is a brief discussion][ringlet-home] of
[Peter Pentchev's solutions][pp-293] to the two problems in
[the 293rd Perl Weekly Challenge][pwc-293].

## General remarks

### Similar Dominos

Once we "order" each tile (put the smaller number first, e.g. (3, 1) becomes (1, 3)),
this problem turns into "how many times do non-unique pairs appear?", which is
actually the same as the classic example of "insert this key into a hash or,
if it is already there, increase the value" - a counting hash, which is kind of
easy to implement in most reasonable programming languages.

### Boomerang

IMHO, the easiest way to solve this problem is to:

- sort the points in ascending order to make some checks easier
- compute (dx1 = abs(dx), dy1 = abs(dy)) for the first and the second point
- compute (dx2 = abs(dx), dy2 = abs(dy)) for the second and the third point
- check if any of those four values are 0 and, if so, produce the correct result
  (which is different depending on which of those values are 0, see below)
- if none of the values are zero, check whether `dx2 / dx1 == dy2 / dy1` or,
  equivalently, whether `dx1 * dy2 == dx2 * dy1`

Checking for zero values must take into account several cases:
- if any of the delta pairs is (0, 0), then two points are the same; return false
- if both delta pairs have 0 as the first or the second element, then all three
  points are on the same horizontal or vertical line; return false
- if any of the pairs has 0 as its first or second element, then two of the points are
  on the same horizontal or vertical line, but the third one is not; return true

Note that this simplistic algorithm will do more work than absolutely necessary if
the first and the third points are the same, since then (dx1, dy1) == (dx2, dy2), but
none of dx1, dy1, dx2, or dy2 are zero. Whatever :)

[pp-293]: https://github.com/manwar/perlweeklychallenge-club/tree/master/challenge-293/ppentchev "Peter Pentchev's solutions on GitHub"
[pwc-293]: https://theweeklychallenge.org/blog/perl-weekly-challenge-293/ "The 293rd Perl Weekly Challenge"
[ringlet-home]: https://devel.ringlet.net/misc/perlweeklychallenge-club/293/ "This page at Ringlet"
