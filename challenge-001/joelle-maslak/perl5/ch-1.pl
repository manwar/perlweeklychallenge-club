#!/usr/bin/env perl
use v5.26;
use strict;
use warnings;

# Challenge:
#   Write a script to replace the character ‘e’ with ‘E’ in the
#   string ‘Perl Weekly Challenge’. Also print the number of times
#   the character ‘e’ is found in the string.

# Methodology:
#   m/e/g will return all the matches in array context.
#   s/e/E/gr uses the "r" modifier to non-destructively modify the
#            original string.

my $orig      = 'Perl Weekly Challenge';
my (@matches) = $orig =~ m/e/g;
my $new       = $orig =~ s/e/E/gr;

say $new;
say "Number off 'e' characters: " . scalar(@matches);


