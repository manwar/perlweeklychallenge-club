#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

my $RE = '^'. '([^0-9a-z]*)([0-9a-z])' x 4; ## Create regex on fly;

my @TESTS = (
  [ ['ab-cde-123', '123.abc.420', '3abc-0010.xy'], ['xx-xxe-123', 'xxx.xbc.420', 'xxxx-0010.xy'] ],
  [ ['1234567.a', 'a-1234-bc', 'a.b.c.d.e.f' ], [ 'xxxx567.a', 'x-xxx4-bc', 'x.x.x.x.e.f' ] ],
);

is( "@{[ my_function(@{$_->[0]}) ]}", "@{$_->[1]}" ) for @TESTS;

done_testing();


sub my_function { map { s{$RE}{$1x$3x$5x$7x}or } @_; }

