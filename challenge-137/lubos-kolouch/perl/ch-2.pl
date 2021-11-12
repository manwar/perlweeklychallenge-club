use strict;
use warnings;

sub is_lychrel_number {
  my $what = shift;

  my $iter_count = 0;
  
  while ($iter_count < 500) {
    $iter_count++;

    $what += reverse $what;

    last if $what >= 10_000_000;

   return 0 if $what == reverse $what;

  }

  return 1;
}

use Test::More;

is(is_lychrel_number(56), 0);
is(is_lychrel_number(57), 0);
is(is_lychrel_number(59), 0);
is(is_lychrel_number(10911), 1);

done_testing;
