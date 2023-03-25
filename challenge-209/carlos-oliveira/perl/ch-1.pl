use strict;
use warnings;
use v5.36;

use Test::More;

sub is_last_bit_a (@bits) {
  my $word = join '', @bits;
  my $is_char_a = 0;
  while ($word =~ /11|10|(0)/g) {
    $is_char_a = defined $1;
  }
  return $is_char_a ? 1 : 0;
}

is is_last_bit_a(1, 0, 0),     1;
is is_last_bit_a(1, 1, 1, 0), 0;

done_testing;
