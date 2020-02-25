#!/usr/bin/env perl
#
# ch-1.pl - Cryptic Message
#
# Ryan Thompson <rjt@cpan.org>

use warnings;
use strict;
use List::MoreUtils qw< frequency >;
use List::Util      qw< reduce >;

sub decode {
    my @r = map y/ //dr, @_;
    join '',   map { reduce { $_->{$a} > $_->{$b} ? $a : $b } keys %$_ }
       reverse map { { frequency map chop, @r } } 1..length $r[0];
}

# Tests

use Test::More;

is decode('H x l 4 !',
          'c e - l o',
          'z e 6 l g',
          'H W l v R',
          'q 9 m # o') => 'Hello';

is decode('P + 2 l ! a t o',
          '1 e 8 0 R $ 4 u',
          '5 - r ] + a > /',
          'P x w l b 3 k \\',
          '2 e 3 5 R 8 y u',
          '< ! r ^ ( ) k 0') => 'PerlRaku';

done_testing;
