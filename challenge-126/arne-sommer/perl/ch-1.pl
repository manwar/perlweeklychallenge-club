#! /usr/bin/env perl

use strict;
use warnings;
use feature 'say';

my $N = $ARGV[0] // die "Please specify a positive integer";
die "Please specify a positive integer" unless $N =~ /^[1-9]\d*$/;

say scalar (grep { $_ !~ /1/ } (2 .. $N));
