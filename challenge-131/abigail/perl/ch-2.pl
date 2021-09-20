#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

#
# See ../README.md
#

#
# Run as: perl ch-2.pl < input-file
#
# First line of input: delimiters
# Second line of input: string to search
#

#
# What a strange way of phrasing the exercise. We're given a string
# of "delimiter pairs", but we actually have to do nothing at all with
# the "delimiter" part.
#
# Basically, we have two sets of characters which we need to extract
# from the string, but for some reason, the two sets of characters
# are interleaved. Weird.
#

chomp (my $chars = <>);
$_ = <>; # String to search

#
# Extract the characters on the odd and even positions;
# replace / with \/.
#
my $odds = $chars =~ s/(.)./$1/gr =~ s!/!\\/!r;
my $even = $chars =~ s/.(.)/$1/gr =~ s!/!\\/!r;

#
# Use y///dc to get rid of the characters which don't match, and
# print the remainder.
# 
say eval "y/$odds//dcr";
say eval "y/$even//dcr";
