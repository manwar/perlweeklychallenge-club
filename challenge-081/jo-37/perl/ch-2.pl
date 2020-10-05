#!/usr/bin/perl

use strict;
use warnings;
use List::Util qw(uniqnum pairgrep pairkeys);

# Use the input data provided by the DATA filehandle if no file name
# is given.
*ARGV = *DATA{IO} unless @ARGV;

# Override some defaults: line endings, field separator and slurp mode
local ($\, $,, $/) = ("\n\n", ' ');

# Build a hash of word/frequency pairs from input data.  Incorporate
# specified exceptions into the split expression.
my %freq;
$freq{$_}++ foreach split qr{[\."),]*\s+[("]*|--|'s\s+}, <>;

# For each frequency, extract the corresponding words from %freq, sort
# and print them.
# Note: "pairkeys" needs to be protected from being interpreted as a
# comparator sub name by sort.
print $_, sort +(pairkeys pairgrep {$b == $_} %freq)
	foreach uniqnum sort {$a <=> $b} values %freq;

__DATA__
West Side Story

The award-winning adaptation of the classic romantic tragedy "Romeo and Juliet". The feuding families become two warring New York City gangs, the white Jets led by Riff and the Latino Sharks, led by Bernardo. Their hatred escalates to a point where neither can coexist with any form of understanding. But when Riff's best friend (and former Jet) Tony and Bernardo's younger sister Maria meet at a dance, no one can do anything to stop their love. Maria and Tony begin meeting in secret, planning to run away. Then the Sharks and Jets plan a rumble under the highway--whoever wins gains control of the streets. Maria sends Tony to stop it, hoping it can end the violence. It goes terribly wrong, and before the lovers know what's happened, tragedy strikes and doesn't stop until the climactic and heartbreaking ending.
