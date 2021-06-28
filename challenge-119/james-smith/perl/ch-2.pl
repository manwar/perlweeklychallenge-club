#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

my @TESTS = ( [5,13],[10,32],[60,2223] );

is( no_11_filter($_->[0]), $_->[1] ) foreach @TESTS;
is( no_11_filter_regex($_->[0]), $_->[1] ) foreach @TESTS;
is( no_11_array( $_->[0]), $_->[1] ) foreach @TESTS;

cmpthese(10_000,{
  'filter' => sub { no_11_filter($_->[0]) foreach @TESTS; },
  'regex' => sub { no_11_filter_regex($_->[0]) foreach @TESTS; },
  'array'  => sub { no_11_array( $_->[0]) foreach @TESTS; },
});

done_testing();

sub no_11_array {
  my( $n, $ptr, @v ) = ( shift, undef, 0 );
  for( my $i = 0; $i < $n; $i++ ) {
    my $ptr;
    for( $ptr = $#v; $ptr>-1 && ++$v[$ptr]>3; $ptr--) {
      $v[$ptr]=1;
    }
    unshift @v,1 if $ptr < 0;
    $i-- if "@v"=~m{1 1};
  }
  return join q(),@v;
}

sub no_11_filter {
  my $n = shift;
  my $v = 0;
  while(1){
    return $v unless $n;
    $v++;
    $n-- if 0 > index( $v,'4')
         && 0 > index( $v,'0')
         && 0 > index( $v,'5')
         && 0 > index( $v,'6')
         && 0 > index( $v,'7')
         && 0 > index( $v,'8')
         && 0 > index( $v,'9')
         && 0 > index( $v,'11');
  }
}
sub no_11_filter_regex {
  my $n = shift;
  my $v = 0;
  while(1){
    return $v unless $n;
    $v++;
    $n-- if $v!~m{(?:[0456789]|11)};
  }
}
