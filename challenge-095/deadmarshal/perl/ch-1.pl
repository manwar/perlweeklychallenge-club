#!/usr/local/bin/perl
use strict;
use warnings;
use feature 'say';

my $N = $ARGV[0];

say $N eq reverse($N) ? 1 : 0;


