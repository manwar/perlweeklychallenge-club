use strict;
use warnings;
use Algorithm::Combinatorics qw/partitions/;

sub is_split_number {
  my $what = shift;
  my $sqr = int(sqrt($what));

  my @what_arr = split //, $what;
  my @what_partitions = partitions(\@what_arr);

  for my $part (@what_partitions) {
    my $result = 0;

    for my $item(@$part) {
      $result += join '',@$item;
    }

    return 1 if $result == $sqr;
  }

  return 0;
}

use Test::More;
is(is_split_number(81), 1);
is(is_split_number(9801), 1);
is(is_split_number(36), 0);

done_testing;
