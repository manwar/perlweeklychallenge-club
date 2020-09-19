#!/usr/bin/env perl
use 5.024;
use warnings;
use experimental qw< postderef signatures >;
no warnings qw< experimental::postderef experimental::signatures >;

sub shift_left_by ($n, @A) { (@A[$n..$#A], @A[0..($n-1)]) }
sub shift_left ($A, $B) { map { [shift_left_by($_, $A->@*)] } $B->@* }

for my $test (
   [
      'first test',
      [qw< 10 20 30 40 50 >],
      [qw< 3 4 >],
   ],
   [
      'second test',
      [qw< 7 4 2 6 3 >],
      [qw< 1 3 4 >]
   ],
) {
   my ($title, $A, $B) = $test->@*;
   say {*STDERR} $title;
   say {*STDOUT} '[', join(', ', $_->@*), ']' for shift_left($A, $B);
}
