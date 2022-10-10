#!/usr/bin/env perl
# Perl weekly challenge 184
# Task 1:  Sequence Number
#
# See https://wlmb.github.io/2022/09/26/PWC184/#task-1-sequence-number
use v5.36;
die <<"EOF" unless @ARGV;
Usage: $0 s1 [s2 ...]
to replace the first 2 characters of strings S1 S2...
by a two digit increasing code.
The strings should be of the form lldddd where l is a letter a..z
and d a digit 0..9.
EOF
die "More than 100 strings" if @ARGV>100;
my $counter="00";
say join ", ",
    map {m/^[a-z]{2}\d{4}$/||die "Bad format $_\n"; s/../$counter++/e; $_}
    @ARGV;
