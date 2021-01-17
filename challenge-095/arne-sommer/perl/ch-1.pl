#! /usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use Scalar::Util qw(looks_like_number);

my $N = $ARGV[0] // die "Specify a number";

die "Not a number" unless looks_like_number($N);

say 0 + ($N eq reverse($N)); 
