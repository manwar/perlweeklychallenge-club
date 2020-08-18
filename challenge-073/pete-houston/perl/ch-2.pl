#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 7302.pl
#
#        USAGE: ./7302.pl N ...
#
#  DESCRIPTION: Given an array of ints print the list of smallest values
#               from the left at each point lower than that element,
#               zero otherwise.
#
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 13/08/20
#===============================================================================

use strict;
use warnings;

my @mins = 0; # Specified in the problem at https://perlweeklychallenge.org/blog/perl-weekly-challenge-073/
my $min = shift;

push @mins, $_ < $min ? ($min = $_ and 0) : $min for @ARGV;

print "@mins\n";
