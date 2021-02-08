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
use Data::Printer;

# Unbuffered STDOUT
$|++;

@ARGV = ('this is a challenge', 'hisen')
  unless (scalar(@ARGV) == 2);

my ($S, $T) = @ARGV;

my $l = length($T);
my @L = (1 .. $l);

my @U;

# I admit... difficult way to find substrings of '$T'
# I think it pays off when '$T' becomes longer
foreach my $cCount (1 .. $l) {
  my $v = variations_with_repetition(\@L,$cCount);

  while (my $a = $v->next) {
    next unless sum(@$a) == $l;
  
    my $re1 = sprintf('^(%s)$', join(')(', map { ".{$_}" } @$a));
    $T =~ m#$re1#;

    my @substrings = map {substr($T, $-[$_], $+[$_]-$-[$_]) } (1 .. scalar(@+) - 1);

    my $i = 0;
    my $re2 = sprintf("%s(?<s%d>.*?)", 
                  join('', map { sprintf("(?<s%d>.*?)(?<t%d>$_)", $i++, $i++) } @substrings),
                  $i);

    # Find all matching combinations    
    while ($S =~ m#$re2#g) {
      my %m = %+;
      my ($pre,$post) = ($`, $');

      # Build the 'evidence' string
      my @s;
      foreach my $k (keys %+) {
        if ($k =~ m#^(.)(\d+)#) { 
          $s[$2] = ($1 eq 's' ? $m{$k} : sprintf("[%s]",$m{$k}));
        }
      }

      push(@U, join('', $pre // '', @s, $post // ''));
    }
  }

}
printf "Input: \$S = '%s', \$T = '%s'\n", $S, $T;
printf "Output: %d\n", scalar(@U);
p @U;
