#!/usr/bin/perl

# Perl Weekly Challenge - 075
# - https://perlweeklychallenge.org/blog/perl-weekly-challenge-075/
#
# Task 1 - Coins Sum
#
# Author: Niels 'PerlBoy' van Dijke


use strict;
use warnings;

use List::Util qw(sum max);
use List::MoreUtils qw(uniq);


# Prototypes
sub getCSsolutions($$\@$\@);
sub printCSsolutions($\@$);


@ARGV = qw(6 1 2 4)
  unless (scalar @ARGV);

my ($SUM, @COINS) = @ARGV;

die "\$S must be a positive integer value"
  unless (defined $SUM and $SUM =~ m#^[1-9][0-9]*$#);
die "Maximum coin size must be <= $SUM"
  unless (max(@COINS) <= $SUM);

@COINS = sort(uniq(@COINS));
die "Coins array size must be >= l"
  unless (scalar @COINS >= 1);

my $csSolutions = {};
my $leftover = $SUM;
my @dummy;


getCSsolutions($csSolutions, $SUM, @COINS, $leftover, @dummy);
printCSsolutions($SUM, @COINS, $csSolutions);


sub getCSsolutions($$\@$\@) {
  my ($hrCS, $sum, $arCoins, $leftover, $arWorkingCoins) = @_;

  my @coins = @{$arCoins};
  my @workingCoins = @{$arWorkingCoins};

  return if ($leftover <= 0);

  foreach my $coin (@coins) {
    if ($coin <= $leftover) {
      push(@workingCoins, $coin);

      @coins = grep { $_ <= $leftover } @coins;

      getCSsolutions($hrCS, $sum, @coins, $leftover - $coin, @workingCoins)
        if (scalar @coins);

      # Check for valid solution, if so deduplicate
      if (sum(@workingCoins) == $sum) {
        my $key = join(', ', sort {$a <=> $b} @workingCoins);
        $hrCS->{$key}++;
      }

      pop(@workingCoins);
    }
  }
}


sub printCSsolutions($\@$) {
  my ($sum, $arCoins, $hrCS) = @_;

  printf "Input:\n";
  printf "\t%s = (%s)\n", '@COINS', join(', ', @$arCoins);
  printf "\t%s = %d\n", '$SUM', $sum;

  my $label = 'a';
  my $nSolutiounsFound = scalar keys %{$hrCS};

  if ($nSolutiounsFound == 0) {
    print "\nNO solution found!\n";
  } else {
    printf "\n%d Solution(s) found:\n\n", $nSolutiounsFound;

    foreach my $k (sort { length($a) <=> length($b) or 
                          $a cmp $b } keys %{$hrCS}) {
       printf "\t%s)\t(%s)\n", $label++, $k;
    }
  }

}
