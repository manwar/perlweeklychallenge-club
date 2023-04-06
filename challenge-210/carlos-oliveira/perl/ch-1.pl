use strict;
use warnings;
use v5.36;

use Test::More;
use List::MoreUtils qw(frequency);

sub kill_and_win (@integers) {
  my %histogram = frequency @integers;
  my $max_score = 0;
  while (my ($integer, $count) = each %histogram) {
    my $score = 0;
    for (my $i = $integer - 1; $i <= $integer + 1; $i++) {
      $score += ($histogram{$i} || 0) * $i;
    }
    $max_score = $score if $score > $max_score;
  }
  return $max_score;
}

is kill_and_win(2, 3, 1),           6;
is kill_and_win(1, 1, 2, 2, 2, 3), 11;

done_testing;
