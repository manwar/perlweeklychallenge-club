#Tries to solve https://perlweeklychallenge.org/blog/perl-weekly-challenge-075/ as perl coding practice.

use strict;
use warnings;
use feature qw(say);
use utf8;
use Getopt::Long;
use List::Util qw(sum first max min);
use Data::Dumper;

my $target;
my @coins;

GetOptions("target=i", \$target,
           "coins=i{1,}" ,\@coins);

@coins = sort @coins;
my @test_array = ($coins[0]) x 1;

my $running = 1;
my $solutions = 0;
while ($running) {
  if (sum(@test_array) == $target) {
    say @test_array;
    ++$solutions;
  }
  if (max(@test_array) == min(@coins) and sum(@test_array) >= $target) {
    $running = 0;
  }
  @test_array = increment_array(@test_array);
}
say $solutions;

sub increment_array {
  my @tarray = @_;
  my $running = 1;
  my $i = 0;
  my $max_idx = scalar @coins - 1;
  while ($running) {
    my $idx;
    $idx = first { $coins[$_] == $tarray[$i] } 0..$#coins;
    if ($idx < $max_idx) {
      $tarray[$i] = $coins[$idx+1];
      $running = 0;
    } elsif ($i+1 == scalar @tarray){
      push @tarray, 1;
      @tarray = ($coins[0]) x @tarray;
      $running = 0;
    } else {
      $tarray[$i] = $coins[0];
    }
    ++$i;
    if ($running == 0) {
      my $max = scalar @tarray;
      foreach (0..$max-2) {
        if ($tarray[$_] < $tarray[$_+1]) {
          $i = 0;
          $running =1;
          last;
        }
      }
    }
  }
  return @tarray;
}
