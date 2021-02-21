#!/usr/bin/perl

# Perl Weekly Challenge - 100
# - https://perlweeklychallenge.org/blog/perl-weekly-challenge-100/
#
# Task 1 - Triangle Sum
#
# Author: Niels 'PerlBoy' van Dijke

use v5.16;
use strict;
use warnings;

use List::Util qw(sum min);

# Prototypes
sub getTriangleSumPaths(\@$$\@\%);
sub printTriangleFlat(\@);
sub printTriangle2D(\@;\@);
sub printTrianglePath(\@\@);


my @T = ([1], [4,2], [2,4,9], [5,5,7,5], [9,2,2,4,8]);
my @P;
my %PP;

getTriangleSumPaths(@T, 0, 0, @P, %PP);
my $min = min(keys %PP);
my @solutions = @{$PP{$min}};

printf "Input: Triangle = \n";
printf "\n";
printf "%s\n", printTriangle2D(@T);
printf "\n";
printf "Output: %d\n", $min;
printf "\n";
printf "Number of solutions: %d\n", scalar(@solutions);
printf "\n";

my $nSol = 1;
foreach my $arP (@solutions) {
  printf "Solution %d:\n", $nSol++; 
  printf "================\n";
  printf "The minimum path sum from top to bottom: %s = %d\n", printTrianglePath(@T,@$arP), $min;
  printf "\n";
  printf "Explanation:\n";
  printf "\n";
  printf "%s\n", printTriangle2D(@T,@$arP);
  printf "\n";
}


sub getTriangleSumPaths(\@$$\@\%) {
  my ($arT, $l, $i, $arP, $hrSP) = @_;

  push(@$arP, $i);
  foreach my $arL ($arT->[$l]) {
    if (defined $arT->[$l+1]) {
      getTriangleSumPaths(@$arT, $l + 1, $i, @$arP, %$hrSP);
      getTriangleSumPaths(@$arT, $l + 1, $i + 1, @$arP, %$hrSP);
    } else {
      my @i = (0 ..  scalar(@$arP) - 1);
      my $sum = sum(map { $arT->[$_][$arP->[$_]] } @i);
      push(@{$hrSP->{$sum}}, [@$arP]);
    }
  }
  pop(@$arP);
}

sub printTriangle2D(\@;\@) {
  my ($arT, $arI) = @_;

  my @out;
  my $maxLen = 0;
  for (my $l = 0; $l < scalar(@$arT); $l++) {
    my $i = 0; 

    push(@out, join(' ', 
                    map { (defined $arI and $arI->[$l] == $i++) ? "[$_]" : $_ 
                        } @{$arT->[$l]}));
    $maxLen = length($out[-1]) 
      if (length($out[-1]) > $maxLen);
  }

  return join("\n", map { "\t" . ' ' x (($maxLen - length($_))/2) . $_} @out);
}


sub printTrianglePath(\@\@) {
  my $lIdx = 0;
  join(' + ', map { $_->[$_[1]->[$lIdx++]] } @{$_[0]});  
}
