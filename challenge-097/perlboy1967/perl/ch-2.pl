#!/usr/bin/perl

# Perl Weekly Challenge - 097
# - https://perlweeklychallenge.org/blog/perl-weekly-challenge-097/
#
# Task 2 - Binary Substrings
#
# Author: Niels 'PerlBoy' van Dijke

use v5.16;
use strict;
use warnings;

use List::Util qw(sum);
use Data::Printer;

# Unbuffered STDOUT
$|++;

my $S = shift(@ARGV) // 3;
my $B = shift(@ARGV) // '101100101';

die "S must be bigger than 1"
  unless ($S > 1);
die "B must be string with only '0' and '1'"
  unless ($B =~ m#^[0-1]+$#);
die "length(B) must be N times S"
  unless (length($B) % $S == 0);

my ($C, $F, @F) = binarySubstrings($B, $S);

printf "Input: \$B = '%s', \$S = %d\n", $B, $S;
printf "Output: %d\n\n", $F;
printf "Binary Substrings and flips needed for common '%s':\n\t%s\n", 
       $C, join("\t", map { "$_\n" } @F);

sub binarySubstrings {
  my ($b, $s) = @_;

  my ($common, $f, @f);

  # Create list of 'b' length substrings / chunks
  my @bitStringChunks = unpack("(A$s)*", $b);

  # Create integer values of 'b' length substrings
  my @intValues = map { oct("0b$_") } @bitStringChunks;

  # Count 0 and 1 bits to find the most frequent bit value
  my $bitPosFreq;
  foreach my $bitString (@bitStringChunks) {
    my $j = 0;
    map { $bitPosFreq->[$j++][$_]++ } reverse split(//, $bitString);
  }
  my @mostBitFreq;
  foreach my $j (0 .. $s - 1) {
    # The challenge didn't provide if we should be in favor of
    # having preference for '0' or '1'. I choose '1'.
    push(@mostBitFreq, ($bitPosFreq->[$j][0] // 0) > ($bitPosFreq->[$j][1] // 0) ?
                       0 : 1);
  }

  my $bestValue = oct(sprintf('0b%s', join('', reverse @mostBitFreq)));
 
  for (my $i = 0; $i < scalar(@bitStringChunks); $i++) {
    my $bitFlips = sum(split(//, sprintf('%b', $intValues[$i] ^ $bestValue)));

    push(@f, sprintf(qq("%s": %d flip(s)), $bitStringChunks[$i], $bitFlips));

    $f += $bitFlips;
  }

  return (sprintf("%0${s}b", $bestValue), $f, @f);
}
