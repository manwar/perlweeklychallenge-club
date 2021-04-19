#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;

my @answer = (9999, 0, 0, 0, 2, 0, 5, 0, 6, 3, 7, 0, 15, 0, 9, 8, 14, 0, 20, 0, 21);


is( chowla($_), $answer[ $_ ] ) foreach 1..20;

done_testing();

sub my_function {
  sub chowla {
    my ($n,$t) = ($_[0],0);
    return map( { $t+=$_ || () }
           map { ( $_ && !($n%$_) ) ? $_ : () }
           2..($n-1)
           ),
           $t;
  }
}

