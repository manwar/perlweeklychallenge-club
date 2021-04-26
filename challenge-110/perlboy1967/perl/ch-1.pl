#!/usr/bin/perl

# Perl Weekly Challenge - 110
# - https://perlweeklychallenge.org/blog/perl-weekly-challenge-110/#TASK1
#
# Task 1 - Valid Phone Numbers
#
# Author: Niels 'PerlBoy' van Dijke

use v5.16;
use strict;
use warnings;

use File::Basename qw(dirname);
use File::Slurp;

use Test::More;
use Test::Deep;

# Prototype(s)
sub validatePhoneNumber($);

# Work relative from script directory
chdir(dirname($0));

cmp_deeply ([map { validatePhoneNumber($_) } read_file('input1.txt')],
            ['0044 1148820341',
              '+44 1148820341',
             '(44) 1148820341']);

done_testing;


# Interpreted the phone number rules to:
# 1)  +nn nnnnnnnnnn:
#    '+' followed 2-4 digits (see: https://countrycode.org/)
#    followed by one or more spaces followed 6 or more digits
# 2) nnnn nnnnnnnnnn:
#    '00' followed by 2-4 digits followed by one or more spaces
#    followed by 6 or more digits
# 3) (nn) nnnnnnnnnn:
#    '(' followed by 2-4 digits followed by ')' followed by
#    one or more spaces followed by 6 or more digits

sub validatePhoneNumber($) {
  my ($n) = @_;

  # trim input
  $n =~ s/^\s*(.+?)\s*$/$1/;

  my ($ccMinLen,$ccMaxLen) = (2,4);
  my $pMinLen = 6;

  return $n if ($n =~ m/(
    ^ \+ \d{$ccMinLen,$ccMaxLen}    \s+ \d{$pMinLen,} $ |
    ^ 00 \d{$ccMinLen,$ccMaxLen}    \s+ \d{$pMinLen,} $ |
    ^ \( \d{$ccMinLen,$ccMaxLen} \) \s+ \d{$pMinLen,} $
  )/x);

  return;
}

