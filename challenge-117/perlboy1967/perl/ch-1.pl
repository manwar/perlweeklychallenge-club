#!/usr/bin/perl

# Perl Weekly Challenge - 117
# - https://perlweeklychallenge.org/blog/perl-weekly-challenge-117/#TASK1
#
# Task 1 - Missing Row(s)
#
# Author: Niels 'PerlBoy' van Dijke

use v5.16;
use strict;
use warnings;

use File::Basename qw(dirname);
use List::MoreUtils qw(slide);

my $input = $ARGV[0] // sprintf('%s/input.txt',dirname($0));

printf "Missing row number(s) of file '%s' is/are '%s'\n", 
       $input, join(',',missingRows($input));


sub missingRows {
  my ($f) = @_;
  
  open(my $fh,'<',$f) || die;

  return map { @$_ } slide {$b - $a > 1 ? [$a + 1 .. $b - 1] : [] }
                     sort { $a <=> $b }
                     map { /^(\d+)/; $_ = $1 }
                     <$fh>;
}
