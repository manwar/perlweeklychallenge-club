#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-151
#

#
# Run as: perl ch-2.pl < input-file
#

use List::Util qw [max];

#
# An algorithm we've seen many times before. For each house, we either
# rob it, or skip it. And we always have to skip the next house.
# Skipping more than two houses in succession is never a good idea, but
# work we'll do extra in the beginning (by skipping more than two house)
# we get back later on, as we're caching all results.
#
sub best;
sub best ($vals, $i = 0) {
    state $cache;
    $i or $cache = [];
    $$cache [$i] ||= $$vals [$i] + max 0, map {best $vals, $_} $i + 2 .. $#$vals
}


say best [/[0-9]+/g] while <>;
