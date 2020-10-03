#! /usr/bin/env perl

use feature 'say';
use List::Util qw/sum/;

my $N = $ARGV[0] // die 'Missing value for $N';

die '$N must be a positive integer' unless $N > 0 && int($N) == $N;

say sum(split("", join("", map { sprintf('%b', $_) } 1 .. $N))) % 1000000007;
