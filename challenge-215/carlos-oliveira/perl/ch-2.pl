use strict;
use warnings;
use v5.36;
use builtin qw(true false);

use Test::More;
use List::Util qw(all);

sub place_ones ($placement_total, $numbers) {
  my @numbers = @$numbers;
  my $placement_count = 0;
  my $interval = 2;
  for (
    my $i = 0;
    $i < @numbers - $interval && $placement_count < $placement_total;
    $i++
  ) {
    next unless all { $_ == 0 } @numbers[$i .. $i+$interval];
    $placement_count++;
    # skip a number since the middle of this interval will be replaced with "1"
    $i++;
  }
  return $placement_count == $placement_total;
}

is place_ones(1, [1,0,0,0,1]), true;
is place_ones(2, [1,0,0,0,1]), false;
is place_ones(3, [1,0,0,0,0,0,0,0,1]), true;
is place_ones(4, [1,0,0,0,0,0,0,0,1]), false;

done_testing;
