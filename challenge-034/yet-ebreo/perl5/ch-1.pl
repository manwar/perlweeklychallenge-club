#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';

my @array = qw(a quick brown fox jumps over the lazy dog);

#Using index
say $array[4];

#Using multiple indices
my @sliced_array = @array[2,3];
say @sliced_array;

#Using range
@sliced_array = @array[2..6];

say @sliced_array;

my $n = 0;
my %hash = map { $_ => $n++ } @array;

#Using one key
say $hash{'jumps'};

#Using array as keys
say @hash{qw(jumps dog a)};