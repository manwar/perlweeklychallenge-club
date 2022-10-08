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

print Dumper split_array_map(               @{$_} ) for @TESTS;
print Dumper split_array_closure(           @{$_} ) for @TESTS;
print Dumper split_array_closure_no_regex(  @{$_} ) for @TESTS;
print Dumper split_array_code(              @{$_} ) for @TESTS;
print Dumper split_array_code_no_regex(     @{$_} ) for @TESTS;

cmpthese( 100_000, {
  'map'                 => sub { split_array_map(               @{$_} ) for @TESTS },
  'closure'             => sub { split_array_closure(           @{$_} ) for @TESTS },
  'closure_no_regex'    => sub { split_array_closure_no_regex(  @{$_} ) for @TESTS },
  'code'                => sub { split_array_code(              @{$_} ) for @TESTS },
  'code_no_regex'       => sub { split_array_code_no_regex(     @{$_} ) for @TESTS },
});

sub split_array_map {
  return [
    [ grep { @{$_} } map { [ grep { /\d/ } split ] } @_ ],
    [ grep { @{$_} } map { [ grep { /\D/ } split ] } @_ ],
  ]
}

sub split_array_closure {
  sub {
    [ [ map { @{$_->[0]} ? $_->[0] : () } @_ ],
      [ map { @{$_->[1]} ? $_->[1] : () } @_ ], ]
  }->(
    map { my $r=[[],[]]; push @{$r->[/[a-z]/]}, $_ for split; $r } @_
  );
}

sub split_array_closure_no_regex {
  sub {
    [ [ map { @{$_->[0]} ? $_->[0] : () } @_ ],
      [ map { @{$_->[1]} ? $_->[1] : () } @_ ], ]
  }->(
    map { my $r=[[],[]]; push @{$r->[$_ gt '@']}, $_ for split; $r } @_
  );
}

sub split_array_code {
  my (@r,@s);
  for (@_) {
    my(@n,@l);
    m/\d/ ? push @n, $_ : push @l, $_ for split;
    push @r, \@n if @n;
    push @s, \@l if @l;
  }
  [\@r,\@s]
}

sub split_array_code_no_regex {
  my (@r,@s);
  for (@_) {
    my(@n,@l);
    '@' gt $_ ? push @n, $_ : push @l, $_ for split;
    push @r, \@n if @n;
    push @s, \@l if @l;
  }
  [\@r,\@s]
}
