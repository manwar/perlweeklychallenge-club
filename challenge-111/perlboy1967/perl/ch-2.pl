#!/usr/bin/perl

# Perl Weekly Challenge - 111
# - https://perlweeklychallenge.org/blog/perl-weekly-challenge-111/#TASK2
#
# Task 2 - Ordered Letters
#
# Author: Niels 'PerlBoy' van Dijke
#
# Wordlist using: CentOS 7 '/usr/share/dict/words' file

use v5.16;
use strict;
use warnings;

use File::Basename qw(dirname);
use File::Slurp;

use Test::More;
use Test::Deep;

# Prototype(s)
sub findLongestOrderedWords($);

# Work relative from script directory
chdir(dirname($0));

cmp_deeply ([findLongestOrderedWords('words')], ['aegilops']);
 
done_testing;


sub findLongestOrderedWords($) {
  my ($wordfile) = @_;
 
  my @inWords = map { chomp; lc($_)} read_file($wordfile);

  my ($wlenMax,@words);
  for my $word (sort { length($b) <=> length($a) } grep /^[a-z]+$/,@inWords) {
    my $wlen = length($word);
    if (!defined $wlenMax or $wlenMax == $wlen) {
      if ($word eq join('',sort split '',$word)) {
        push(@words, $word);
        $wlenMax = $wlen;
      }
    } elsif ($wlen < $wlenMax) {
      last;
    }
  }

  return @words;
}
