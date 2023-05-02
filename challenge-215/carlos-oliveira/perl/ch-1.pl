use strict;
use warnings;
use v5.36;

use Test::More;

sub out_with_the_odds ($words) {
  my $original_size = @$words;
  @$words = grep {
    my @letters = sort split //, $_;
    join('', @letters) eq $_;
  } @$words;
  return $original_size - @$words;
}

is out_with_the_odds(['abc', 'xyz', 'tsu']), 1;
is out_with_the_odds(['rat', 'cab', 'dad']), 3;
is out_with_the_odds(['x', 'y', 'z']), 0;

done_testing;
