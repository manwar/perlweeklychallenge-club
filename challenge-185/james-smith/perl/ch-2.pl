#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

say my $RE = join '([^0-9a-z]*)', ( '[0-9a-z]' ) x 4;

my @TESTS = (
  [ ['ab-cde-123', '123.abc.420', '3abc-0010.xy'], [ 'xx-xxe-123', 'xxx.xbc.420', 'xxxx-0010.xy'] ],
  [ ['1234567.a',  'a-1234-bc',   'a.b.c.d.e.f' ], [ 'xxxx567.a',  'x-xxx4-bc',   'x.x.x.x.e.f' ] ],
);

is( "@{[ solreg(  @{$_->[0]}) ]}", "@{$_->[1]}" ) for @TESTS;
is( "@{[ solreghc(@{$_->[0]}) ]}", "@{$_->[1]}" ) for @TESTS;
is( "@{[ solsplit(@{$_->[0]}) ]}", "@{$_->[1]}" ) for @TESTS;

done_testing();
cmpthese( 100_000, {
  'reg'    => sub { solreg(   @{$_->[0]} ) for @TESTS; },
  'reghc'  => sub { solreghc( @{$_->[0]} ) for @TESTS; },
  'split'  => sub { solsplit( @{$_->[0]} ) for @TESTS; },
});

sub solreg   { map { s{$RE}{x$1x$2x$3x}or                                                                 } @_ }
sub solreghc { map { s{[0-9a-z]([^0-9a-z]*)[0-9a-z]([^0-9a-z]*)[0-9a-z]([^0-9a-z]*)[0-9a-z]}{x$1x$2x$3x}r } @_ }
sub solsplit { map { join 'x', split /[0-9a-z]/, $_, 5;                                                   } @_ }

