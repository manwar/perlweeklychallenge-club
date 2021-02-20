#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;

is( ft( '05:15pm' ), '17:15' );
is( ft( '05:15 pm' ), '17:15' );
is( ft( '17:15' ), '05:15pm' );
is( ft( '05:15am' ), '05:15' );
is( ft( '05:15 am' ), '05:15' );
is( ft( '05:15' ), '05:15am' );
is( ft( '00:00' ), '12:00am' );
is( ft( '12:00' ), '12:00pm' );
is( ft( '24:00' ), '12:00am' );
is( ft( '12:00 am' ), '00:00' );
is( ft( '12:00 pm' ), '12:00' );

is( fun_time( '05:15pm' ), '17:15' );
is( fun_time( '05:15 pm' ), '17:15' );
is( fun_time( '17:15' ), '05:15pm' );
is( fun_time( '05:15am' ), '05:15' );
is( fun_time( '05:15 am' ), '05:15' );
is( fun_time( '05:15' ), '05:15am' );
is( fun_time( '00:00' ), '12:00am' );
is( fun_time( '12:00' ), '12:00pm' );
is( fun_time( '24:00' ), '12:00am' );
is( fun_time( '12:00 am' ), '00:00' );
is( fun_time( '12:00 pm' ), '12:00' );

done_testing();

## 72 chars ############################################################

## Just split so slightly more readable and fits on 60 char lines
## Not nasty hack - we pop rather than shift as it saves 2 bytes!
## We assume that the minute portion will be two digits after the
## ":" then we don't need to check it....

## 113 bytes total - 105 inside the curly braces..

sub ft{pop=~s/(.+)(:..)\s*(.m|)/sprintf'%02d%s%s',
($1%12||(12*!$3))+12*('pm'eq$3),$2,$3?'':$1%24<12?'am':'pm'/re}

## This is more readable version with notes...
sub fun_time {
  return pop =~
    ## Note the nasty hack we pop rather than shift - that saves 2 bytes
    ## in our golfdom....
    s/
        ## Split into 3 parts, $1 - hours, $2 - minutes & $3 - am-pm
      (.+) (:..) \s* ( .m | )
        ## We assume all strings are valid - so we don't have to anchor
        ## at both ends or worry what the 12hr clock sufficies are
        ## am-pm and .m is shorter than [ap]m
        ##
        ## We assume that the time will always have a : followed
        ## 2 digits...
        ##
        ## Note if we right (.m)? the 3rd capture variable $3 is
        ## sometimes undefined - better is to use (.m|) which
        ## matches the same way but $3 is now an empty string not
        ## undefined when we have a 24 hour clock time
    /
      sprintf '%02d%s%s',
        ( $1 % 12 || ( 12 * ! $3 ) ) + 12 * ( 'pm' eq $3 ),
          ## Get hour modulo 12..
          ## From 24hr to 12hr clock we need to convert 00:?? to 12:??
          ## From 12hr to 24hr clock it is pm we then need to add 12...
          ## Note we use the "yoda condition" for the equals
          ##   'pm'eq$3
          ## as this is a byte shorter than the more usual way of
          ## writing inequalitys
          ##   $3 eq'pm'
          ## as we don't need a space between the $3 & the eq...
        $2,
          ## The minutes is the easy bit just copy..
        $3 ? '' : $1 < 12 || $1 == 24 ? 'am' : 'pm'
          ## If we are converting from 12hr clock the third string is
          ## empty - if not and the time is <12 we return am otherwise pm
    /rex;
}

