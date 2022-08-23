#!/usr/bin/perl

use v5.16;
use List::MoreUtils 'minmax';
use Math::Round 'round';

die <<EOS unless @ARGV;
usage: $0 N1 N2 ...

N1 N2 ...
    Numbers to be represented in a sparkline-like bar chart.

EOS


### Input and Output

binmode STDOUT, ':utf8';
say barchart(@ARGV);


### Implementation

# A vague solution for a vague task:  I didn't find any Unicode
# symbols that could be used to produce sparklines.  Using
# ${SEARCH_ENGINE} revealed some implementations that produce small
# bar charts using Unicode symbols.  Following this approach.
#
# Starting with U+2581 ("\N{LOWER ONE EIGHTH BLOCK}"), there are eight
# consecutive block symbols having a height of one to eight eights that
# will be used here.  Returning a list of characters.

sub barchart {
    my ($min, $max) = minmax @_;
    my $scale = 7 / (($max - $min) || 1);
    map chr(0x2581 + round(($_ - $min) * $scale)), @_;
}
