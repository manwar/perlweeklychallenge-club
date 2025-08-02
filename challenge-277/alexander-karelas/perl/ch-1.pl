#!/usr/bin/env perl

use v5.40;

my @words1 = ("Perl", "is", "my", "friend");
my @words2 = ("Perl", "and", "Raku", "are", "friend");

# Solution:
my %hash;
@hash{ @words1 } = ();
my $num_common = grep exists $hash{$_}, @words2;

say $num_common;
