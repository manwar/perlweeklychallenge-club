#!/usr/bin/env perl
use strict;
use warnings;
use utf8;
use Unicode::Normalize; # 'NKFD'
use Encode 'encode';

# Task 2: Unicode Makeover
# Submitted by: Mohammad S Anwar

# You are given a string with possible unicode characters.

# Create a subroutine sub makeover($str) that replace the unicode characters with ascii equivalent. For this task, let us assume it only contains alphabets.

# Example 1
# Input: $str = 'ÃÊÍÒÙ';
# Output: 'AEIOU'
# Example 2
# Input: $str = 'âÊíÒÙ';
# Output: 'aEiOU'

sub makeover {
  my $str = shift;

  return encode( 'ascii', NFKD($str), sub {q{}} );
}

use Test::More;

is makeover('ÃÊÍÒÙ'), 'AEIOU', 'first example';
is makeover('âÊíÒÙ'), 'aEiOU', 'second example';

done_testing;