#!/usr/local/bin/perl

use strict;
use warnings;
use feature qw(say);
use Test::More;

my $SIZE = 100;
my @list  = map { chr(97+rand(26)) x 3 } 1..$SIZE;

my @TESTS = (
  [ [qw(adc wzy abc)], 'abc' ],
  [ [qw(bob bbb ccc ddd)], 'bob' ],
  [ [qw(aaa bob ccc ddd)], 'bob' ],
  [ [qw(aaa bbb bob ddd)], 'bob' ],
  [ [qw(aaa bbb ccc bob)], 'bob' ],
  ## Put "bob" in every position within the list...
  map { my $t = [ @list ]; $t->[$_]='bob'; [ $t, 'bob' ] } 0..$SIZE-1
);

is( odd_string_sig(       @{$_->[0]} ), $_->[1] ) for @TESTS;
is( odd_string_sig_check( @{$_->[0]} ), $_->[1] ) for @TESTS;
is( odd_string_eqs(       @{$_->[0]} ), $_->[1] ) for @TESTS;

## Support method - create a signature string for the string
## where strings are the difference in `ord` between pairs
## adjusted so they are greater than 0 (and visible)

sub sig_str {
  my @Q = map { ord $_ } split //,$_[0];
  join '', map { chr(96 + $Q[$_]-$Q[$_+1]) } 0..$#Q-1
}

## Rather than converting to a string - we store as an
## arrayref of differences
sub sig {
  my @Q = map { ord $_ } split //,$_[0];
  [ map { $Q[$_]-$Q[$_+1] } 0..$#Q-1 ]
}

## Now we do a comparison of pre-defined arrayref
## and a string, we don't store the sig of the string
## just a 0/1 return value...
sub sig_check {
  my( $sig, $str ) = @_;
  my @Q = map { ord $_ } split //,$str;
  $Q[$_]-$Q[$_+1] == $sig->[$_] || return 0 for 0..$#Q-1;
  return 1
}

## Comparison by computing signature string of each sting
## and comparing them..
sub odd_string_sig {
  my $x = sig_str( $_[0] );
  return $_[ $x eq sig_str( $_[2] ) ] if $x ne sig_str( $_[1] );
  splice@_,0,2;
  $x eq sig_str( $_ ) || return $_ for @_
}

## Use array version of signature and sig check..
sub odd_string_sig_check {
  my $x = sig( $_[0] );
  return $_[ sig_check( $x, $_[2] ) ] if !sig_check( $x, $_[1] );
  splice@_,0,2;
  sig_check( $x, $_ ) || return $_ for @_
}

## A slightly left field approach.
## Take the first word and find all words that have the same
## signature {we find lowest and highest letters in list to
## reduce the search space for the list}
## Now we check to see if subsequent words are in the list
## If 2nd word is in the list then we look first the first
##   word that isn't 
## If 2nd wors isn't in the list then we need to check on
## 3rd word - if in list then the first word is the one
## we want - if not it's the 2nd.....

sub odd_string_eqs {
  my @Q = map { ord $_ } split//,$_[0];
  my $l=255;
  $l > $_ && ($l=$_) for @Q;
  my $h=0;
  $h < $_ && ($h=$_) for @Q;
  my %eqs = map {
    my $o = $_;
    join( '', map {chr $_+$o} @Q ) => 1
  } 97-$l .. 122-$h;
  return $_[ exists $eqs{$_[2]} ]
    unless   exists $eqs{$_[1]};
  splice@_,0,2;
  exists $eqs{$_} || return $_ for @_
}
