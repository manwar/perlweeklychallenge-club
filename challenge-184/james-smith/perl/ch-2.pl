#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

my @TESTS = (
  [ 'a 1 2 b 0', '3 c 4 d' ],
  [ '1 2', 'p q r', 's 3', '4 5 t' ],
);

print Dumper split_array_map(  @{$_} ) for @TESTS;
print Dumper split_array_code( @{$_} ) for @TESTS;

sub split_array_map {
  return [
    [ grep { @{$_} } map { [ grep { m/\d/ } split ] } @_ ],
    [ grep { @{$_} } map { [ grep { m/\D/ } split ] } @_ ],
  ]
}

cmpthese( 100_000, {
  'map'  => sub { split_array_map(  @{$_} ) for @TESTS },
  'code' => sub { split_array_code( @{$_} ) for @TESTS },
});

sub split_array_code {
  my (@r,@s);
  for (@_) {
    my(@n,@l);
    m{\d} ? push( @n,$_ ) : push( @l,$_ ) for split;
    push @r, \@n if @n;
    push @s, \@l if @l;
  }
  [\@r,\@s]
}
