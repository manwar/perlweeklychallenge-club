#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

my @TESTS = (
  [ [qw(1 2 3 6 7 8 9)] ,    '([1, 2, 3], [6, 7, 8, 9])'      ],
  [ [qw(11 12 14 17 18 19)], '([11, 12], [14], [17, 18, 19])' ],
  [ [qw(2 4 6 9)],           '([2], [4], [6], [9])'           ],
  [ [qw(1 2 3 4 5)],         '([1, 2, 3, 4, 5])'              ],
);

is( con_dump(conseq($_->[0])), $_->[1] ) foreach @TESTS;
done_testing();

say sprintf '  %-18s -> %s', "@{$_->[0]}", con_dump( conseq( $_->[0] ) ) foreach @TESTS;

sub con_dump {
  ## Join each sublist with ', ' & wrap in []
  ## join each of these results together with ', ' & wrap in ()
  return sprintf '(%s)', join ', ',map { sprintf '[%s]', join ', ', @{$_} } @{$_[0]};
}

sub conseq {
  my @val = @{$_[0]};            ## Store parameters in array val...
  my @res = ( [shift @val] );    ## Initiliase the results array by placing the
                                 ## first number into first list of response
  ## If consecutive            ## Add to last list     ## Create new list
  ( $_ == 1 + $res[-1][-1] ) ? (push @{$res[-1]},$_) : (push @res,[$_]) foreach @val;
  \@res;
}

