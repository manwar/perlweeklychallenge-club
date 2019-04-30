#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

use Math::Combinatorics;

my @letters = split //, shift;
my $iter = 'Math::Combinatorics'->new(data  => \@letters);
my %seen;
$seen{$_}++ or say $_ while $_ = join '', $iter->next_permutation;
