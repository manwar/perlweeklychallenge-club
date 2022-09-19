#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);

my $N = $ARGV[0]//20;

##----------------------------------------------------------------------
## Fron task 1 we steal our "recursive" compose function
## so we can stitch methods together.
##----------------------------------------------------------------------

sub compose {
  my($g,$f) = pop;
  @_ && ($f = pop) ? compose( @_, sub { $f->($g->(@_)) } ) : $g
}

##----------------------------------------------------------------------
## Create the two is_abundant methods - a simple sub and our composite
## first-class function.
##----------------------------------------------------------------------

sub is_abundant {
  my $s = 1 - (my $t = pop);
  $s += $t%$_ ? 0 : $_ + ( $t-$_*$_ && $t/$_ ) for 2 .. sqrt $t;
  $s>0
}

## Create first-class functions for the three stages...

    ## Find factors... We add -$t to the list as we want to add up sum
    ## of factors > $t...
my $factor = sub { my $t = pop;
  -$t, 1, map { $t%$_ ? () : $t-$_*$_ ? ($_,$t/$_) : $_ } 2..sqrt $t };

my $sum    = sub { my $s = 0; $s+=$_ for @_; $s };

my $check  = sub { pop > 0 };

## Combine them into a single first class function...

my $is_abundant = compose $check, $sum, $factor;

##----------------------------------------------------------------------
## Generate output from the two methods...
##----------------------------------------------------------------------

## Loop one - using the simple function...

say '';
my $k = 1;    is_abundant($k+=2) ? say $k : redo for 1..$N;
say '';

## Loop two - using the first-class function..

my $t = 1; $is_abundant->($t+=2) ? say $t : redo for 1..$N;
say '';

