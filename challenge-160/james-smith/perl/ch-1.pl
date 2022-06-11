#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);
use Lingua::EN::Numbers qw(num2en);

my @TESTS = (
  [ 5, 'Five is four, four is magic.' ],
  [ 7, 'Seven is five, five is four, four is magic.' ],
  [ 6, 'Six is three, three is five, five is four, four is magic.' ],
);

say magic($_) for 0..1000;
is( magic($_->[0]), $_->[1] ) foreach @TESTS;

done_testing();

sub magic {
  my $r = ucfirst num2en( my $n = shift ).' is ';
  $r .= join num2en( $n = length num2en($n)=~s/\W//rg ), '', ', ', ' is ' until $n==4;
  $r.'magic.';
}

