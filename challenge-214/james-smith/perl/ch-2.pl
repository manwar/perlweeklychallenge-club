#!/usr/local/bin/perl

use strict;
use warnings;
use feature qw(say);
use Test::More;

my @TESTS = (
  [ [2,4,3,3,3,4,5,4,2], 23 ],
  [ [1,2,2,2,2,1], 20 ],
  [ [1], 1 ],
  [ [2,2,2,1,1,2,2,2], 40 ],
  [ [2,1,2,1,2,1,2,1,2,1,2,1,2,1,2], 1 ],
);

my($cache,$m);

sub collect {
  return 0 unless @_;
  my $m = 0;
  for ( my $e = my $o = 0; $o<@_; ) {
    my $e = $o;
    $e++ while $_[$o]==$_[$e];
    sub { $m=$_[0] if $m<$_[0] }->(
      ($e-$o)**2 +
      collect( @_[ 0..$o-1, $e..$#_ ] )
    );
    $o = $e
  }
  $m
}

sub collect_cache {
  return 0 unless @_;
  my $k = "@_";
  return $cache->{$k} if exists $cache->{$k};
  my $m = 0;
  for ( my $e = my $o=0; $o<@_; ) {
    my $e = $o;
    $e++ while $_[$o]==$_[$e];
    my $s = ($e-$o)**2 + collect_cache( @_[ 0..$o-1, $e..$#_ ] );
    $m = $s if $s > $m;
    $o = $e;
  }
  $cache->{$k} = $m;
}

sub _collect_fast {
  my $s = shift;
  return $s unless @_;  ## Empty list return score
  
  ## same digits.
  for ( my $e = my $o = 0; $o<@_; ) { ## We loop through
    my $e = $o;                ## the list for each                                    
    $e++ while $_[$o]==$_[$e]; ## sequence of same no.

    ## Compute the score so far $s + length of seq^2
    ## Compute max poss. score this + sum of squared
    ## counts of other number frequencies

    my $ms = my $ts = $s + ($e-$o)**2;
    my %f = ($_[$o] => $o-$e);
    $f{$_}++ for @_;
    $ms += $_ ** 2 for values %f;

    ## If the max possible score is > $m we compute
    ## actual score and update max if > $m

    if($ms>$m) {
      $ts = _collect_fast( $ts, @_[ 0..$o-1, $e..$#_ ] );
      ## And if it is greater than $m we update $m
      $m = $ts if $ts > $m;
    }
    $o = $e;
  }
}

sub collect_fast {
  return 0 unless @_;
  my %f;
  $m=0;
  $f{$_}++ for @_;                  ## compute freq
  $_>$m && ( $m=$_ ) for values %f; ## find largest
  $m = $m*$m + @_-$m;  ## Compute minimum-maximum
                       ## square of max freq -
                       ## count of remaining
  _collect_fast(0,@_); ## Now do the real work
  $m                   ## Return max (global variable)
}

          is(       collect( @{$_->[0]} ), $_->[1] ) for @TESTS;
          is(  collect_fast( @{$_->[0]} ), $_->[1] ) for @TESTS;
$cache={},is( collect_cache( @{$_->[0]} ), $_->[1] ) for @TESTS;
done_testing();
