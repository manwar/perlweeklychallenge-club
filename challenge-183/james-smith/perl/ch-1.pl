#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);
use List::MoreUtils qw(zip6);

my @Q = map { [1..$_] } 1..8_000;
my @Q2 = ( @Q, [1..3] );
my @TESTS = (
  [
    [ [1,2], [3,4], [5,6], [1,2] ],
    [ [1,2], [3,4], [5,6] ]
  ],
  [
    [ [9,1], [3,7], [2,5], [2,5] ],
    [ [9,1], [3,7], [2,5] ]
  ],
  [
    [ ['1 2','3 4'], [ 1,2,3,4 ], [ 1, '2 3', 4 ] ],
    [ ['1 2','3 4'], [ 1,2,3,4 ], [ 1, '2 3', 4 ] ]
  ],
  [ [ @Q ], [ @Q ] ],
  [ [ @Q2 ], [ @Q ] ],
);

timethis( 2, sub { unique_array_array(          @{$_->[0]}) for @TESTS } );
timethis( 2, sub { unique_array_stringify_fixed(@{$_->[0]}) for @TESTS } );

is_deeply( unique_array_array(          @{$_->[0]}), $_->[1] ) for @TESTS;
is_deeply( unique_array_stringify(      @{$_->[0]}), $_->[1] ) for @TESTS;
is_deeply( unique_array_stringify_fixed(@{$_->[0]}), $_->[1] ) for @TESTS;

#cmpthese( 10, {
#  'string' => sub { unique_array_stringify_fixed(@{$_->[0]}) for @TESTS },
#  'array'  => sub { unique_array_array(          @{$_->[0]}) for @TESTS },
#});
done_testing();

sub unique_array_stringify {
  my @r    = (shift);
  my %seen = ("@{$r[0]}" => 1);
  (!$seen{"@{$_}"}++) && (push @r,$_) for @_;
  \@r;
}

sub unique_array_stringify_fixed {
  local $" = '\0\0\0';
  my @r    = (shift);
  my %seen = ("@{$r[0]}" => 1);
  (!$seen{"@{$_}"}++) && (push @r,$_) for @_;
  \@r;
}

sub unique_array_array {
  my @r = (shift);
  O: for my $e (@_) {
    R: for my $s (@r) {
      ## Diffrent length so definitely don't match
      next unless @{$s} == @{$e};
      ## If any of the elements in the loop is different
      ## not a match so go through to the next element
      ($_->[0] ne $_->[1]) && (next R) for zip6 @$e, @$s;
      ## All are the same... so we have already seen this
      ## array so we skip to the next!
      next O;
    }
    ## Must be unique so push it to our answer
    push @r,$e;
  }
  \@r;
}
