#!/usr/bin/perl

# Perl Weekly Challenge - 099
# - https://perlweeklychallenge.org/blog/perl-weekly-challenge-099/
#
# Task 2 - Unique Subsequence
#
# Author: Niels 'PerlBoy' van Dijke

use v5.16;
use strict;
use warnings;

use Algorithm::Combinatorics qw(variations_with_repetition);
use List::Util qw(sum);
use List::MoreUtils qw(uniq);
use Data::Printer;

# Prototypes
sub getSubstrings($);
sub getUniqueSubsequence($\@\@\@);

# Unbuffered STDOUT
$|++;

@ARGV = ('supercalifragilisticexpialidocious', 'uplis')
  unless (scalar(@ARGV) == 2);

my ($S, $T) = @ARGV;
my @U;

foreach my $arSs (getSubstrings($T)) {
  my @m;
  getUniqueSubsequence($S, @$arSs, @m, @U);
}

printf "Input: \$S = '%s', \$T = '%s'\n", $S, $T;
printf "Subresult:\n";
p @U;

@U = sort(uniq(map { s#\]\[##g; $_} @U));

printf "Output: %d\n", scalar(@U);
p @U;

sub getSubstrings($) {
 my ($t) = @_;

  my @r;

  my $l = length($t);
  my @L = (1 .. $l);

  # I admit... difficult way to find substrings of '$t'
  # but its cool, so why not?
  foreach my $cCount (1 .. $l) {
    my $v = variations_with_repetition(\@L,$cCount);

    while (my $a = $v->next) {
      next unless sum(@$a) == $l;
  
      my $re1 = sprintf('^(%s)$', join(')(', map { ".{$_}" } @$a));
      $T =~ m#$re1#;

      push(@r, [map {substr($T, $-[$_], $+[$_]-$-[$_]) } (1 .. scalar(@+) - 1)]);
    }
  }

  return @r;
}


sub getUniqueSubsequence($\@\@\@) {
  my ($s, $arSs, $arMs, $arRes) = @_;

  my @ss = @$arSs;
  my $ss = shift(@ss);

  while ($s =~ m#$ss#g) {
    my ($pre, $post) = ($`, $');

    if (scalar @ss) {
      push(@$arMs, "$pre\[$ss]");
      getUniqueSubsequence($post, @ss, @$arMs, @$arRes);
      pop(@$arMs);
    } else {
      push(@$arRes, join('', @$arMs, $pre, qq([$ss]), $post));
    }
  }
}
