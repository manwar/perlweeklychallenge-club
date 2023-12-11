#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉ ≡ ≢ «␤ » ∴
use v6;
use Test;

=begin comment

246-1: 6 out of 49
Submitted by: Andreas Voegele
6 out of 49 is a German lottery.

Write a script that outputs six unique random integers from the range 1 to 49.

Output
3
10
11
22
38
49
=end comment

my @l = 1 … 6;
say "Output:";
.say for (1…49).pick( 6);
exit;

