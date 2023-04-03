use strict;
use warnings;
use v5.36;

use Test::More;

sub collide_numbers (@integers) {
  my @result;
  OUTER_LOOP:
  for (my $i = 0; $i < @integers; $i++) {
    my $increment = $integers[$i] > 0 ? 1 : -1;
    my $stop_condition = $integers[$i] > 0 ? sub { $_[0] < @integers } : sub { $_[0] >= 0 };

    for (my $u = $i + $increment; $stop_condition->($u); $u = $u + $increment) {
      next unless $integers[$i] * $integers[$u] < 0;
      next OUTER_LOOP if abs($integers[$i]) <= abs($integers[$u]);
    }
    push @result, $integers[$i];
  }
  return @result;
}

is_deeply [collide_numbers(2, 3, -1)], [2, 3];
is_deeply [collide_numbers(3, 2, -4)], [-4];
is_deeply [collide_numbers(1, -1)],    [];

done_testing;
