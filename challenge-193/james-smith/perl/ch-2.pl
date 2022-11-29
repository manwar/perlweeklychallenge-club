#!/usr/local/bin/perl

use strict;
use warnings;
use feature qw(say);
use Test::More;

my $SIZE = 100;

my %map2  = map { my $a=$_; map { ("$a$_" => ord($a)-ord($_)) } 'a'..'z' } 'a'..'z';
my %map3  = map { my $b = $_; map { my $a=$_; map { ("$a$b$_" => ord($a)*99-ord($b)*100+ord($_)) } 'a'..'z' } 'a'..'z' } 'a'..'z';
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
my @TESTS = 
  @lists,
);

is( odd_string_array(  @{$_->[0]} ), $_->[1] ) for @TESTS;
is( odd_string_ord(    @{$_->[0]} ), $_->[1] ) for @TESTS;
is( odd_string_map_2(  @{$_->[0]} ), $_->[1] ) for @TESTS;
is( odd_string_map_3(  @{$_->[0]} ), $_->[1] ) for @TESTS;

sub odd_string {
  my %x;
  ## Keyed by signature - so one key will have
  push @{$x{
      ord( substr $_, 1 ) *  99
    + ord( substr $_, 2 )
    - ord( $_           ) * 100
  }}, $_ for @_;
  [ grep { @{$_}==1 } values %x ]->[0][0]
}

sub odd_string_ord {
  my($x1,$x2) = (
                    ord($_[0]) - ord(substr$_[0],1),          ord($_[0]) - ord(substr$_[0],2),
  );
  ## The first two characters are different - so we need to check the first against the third
  ## If it is the same then the character we want is the second character o/w the first
  ## Note the comparison returns 1 if true & 0 if false so can use that as the index to @_
  return $_[ $x1 == ord($_[2]) - ord(substr$_[2],1) && $x2 == ord($_[2]) - ord(substr$_[2],2) ]
      if     $x1 != ord($_[1]) - ord(substr$_[1],1) || $x2 != ord($_[1]) - ord(substr$_[1],2);
  ## We remove the first two strings as we don't need to compare them...
  splice@_,0,2;
  ## Compare all strings {we will end up with an answer as we know there is a unique string
  (          $x1 != ord($_   ) - ord(substr$_,1)    || $x2 != ord($_)    - ord(substr$_,2   ) ) && return $_ for @_;
  ## in the list...
}

## Pre compute `ord($a) - ord($b)` for two letters [keyed with the string `"$a$b"`] and use
## this to avoid the repeated ord calculation.... (676 entries)
## This isn't as efficient as the ord calculation tho!
sub odd_string_map_2 {
  my($x1,$x2) = (   $map2{ substr $_[0],0,2 },          $map2{ substr $_[0],1,2 } );
  return $_[ $x1 == $map2{ substr $_[2],0,2 } && $x2 == $map2{ substr $_[2],1,2 } ]
      if     $x1 != $map2{ substr $_[1],0,2 } || $x2 != $map2{ substr $_[1],1,2 };
  splice@_,0,2;
  (          $x1 != $map2{ substr $_,   0,2 } || $x2 != $map2{ substr $_,   1,2 } ) && return $_ for @_;
}

## Pre compute the signature for all triples (17,576 entries)
## this to avoid the repeated ord calculation...., and now the `substr` operation
## as well - this gives us the simpler code....

sub odd_string_map_3 {
  my         $x =  $map3{ $_[0] };
  return $_[ $x == $map3{ $_[2] } ]
      if     $x != $map3{ $_[1] };
  splice@_,0,2;
             $x == $map3{ $_    } || return $_ for @_;
}

