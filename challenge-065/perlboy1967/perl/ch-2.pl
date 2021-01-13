#!/usr/bin/perl

# Perl Weekly Challenge - 065
#
# Task 2 - Palindrome Partition
#
# Author: Niels 'PerlBoy' van Dijke

use strict;
use warnings;

use List::Util qw(max);

sub getPalindromes ($);

my @input = (
  'aabaab',
  'abbaba',
  'zabcbaz',
  'cedzdebaaccaa',
);

my $minlen = 2;

my $maxlen = max(map{length($_)} @input);

my %pRE;


# Building some "palindrome detection regexp'es" for later use
for my $len ($minlen .. $maxlen) {
  my $half = int($len/2);
  $pRE{$len} = sprintf('(.*?)((%s)%s%s)(?<right>.*)', 
                       join(')(', ('.') x $half), 
                       ($len % 2 == 0 ? '' : '.'),
                       join('', map ( '\\'.($half - $_ + 3), 1 .. $half)));
}

for my $input (@input) {
  my @palindromeSolutions = getPalindromes($input);

  print "'$input' contains the following unique palindromes:\n"; 
  my $solution = 1;
  foreach my $p (@palindromeSolutions) {
    printf "%d)\t%s\n", $solution++, join(', ', @$p);
  }
}

sub getPalindromes ($) {
  my ($input) = @_;
  
  my @p; 
  for my $i (2 .. length($input)) {
    if ($input =~ m#$pRE{$i}#) {
      my ($left, $llen, $palindrome, $right) = ($1, length($1), $2, $+{right});
      next if (defined $llen && $llen > 1 && $left =~ m#$pRE{$llen}#);
      my @pr;
      if (length($right) > 1 ) {
        @pr = getPalindromes($right);
      }   
      if (@pr) {
         map { push(@p, [$palindrome, @{$_}]) } @pr;
      } else {
        push(@p, [$palindrome]);
      }
    }  
  }
  return @p;
}
       

