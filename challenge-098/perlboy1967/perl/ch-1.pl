#!/usr/bin/perl

# Perl Weekly Challenge - 098
# - https://perlweeklychallenge.org/blog/perl-weekly-challenge-098/
#
# Task 1 - Read N-characters
#
# Author: Niels 'PerlBoy' van Dijke

BEGIN {
  use File::Basename qw(dirname);
  chdir(dirname($0));
}

use v5.16;
use strict;
use warnings;

use lib '.';

use readN qw(readN);

# Unbuffered STDOUT
$|++;


@ARGV = qw(1 input1.txt input2.txt) 
  unless scalar(@ARGV);

my $len = shift @ARGV // 4;
my %files = map {$_ => 1} @ARGV;

do {
  foreach my $file (sort keys %files) {
    my $s = readN($file, $len);
    if (defined $s) {
      printf "$file |%s|\n", $s;
    } else {
      delete $files{$file};
    }
  }
} while (scalar(keys %files) > 0);

