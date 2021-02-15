#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;

is( fun_time( '05:15pm' ), '17:15' );
is( fun_time( '05:15 pm' ), '17:15' );
is( fun_time( '17:15' ), '05:15pm' );
is( fun_time( '05:15am' ), '05:15' );
is( fun_time( '05:15 am' ), '05:15' );
is( fun_time( '05:15' ), '05:15am' );
is( fun_time( '00:00' ), '12:00am' );
is( fun_time( '12:00' ), '12:00pm' );
is( fun_time( '24:00' ), '12:00pm' );
is( fun_time( '12:00 am' ), '00:00' );
is( fun_time( '12:00 pm' ), '12:00' );

is( fun_time_readable( '05:15pm' ), '17:15' );
is( fun_time_readable( '05:15 pm' ), '17:15' );
is( fun_time_readable( '17:15' ), '05:15pm' );
is( fun_time_readable( '05:15am' ), '05:15' );
is( fun_time_readable( '05:15 am' ), '05:15' );
is( fun_time_readable( '05:15' ), '05:15am' );
is( fun_time_readable( '00:00' ), '12:00am' );
is( fun_time_readable( '12:00' ), '12:00pm' );
is( fun_time_readable( '24:00' ), '12:00pm' );
is( fun_time_readable( '12:00 am' ), '00:00' );
is( fun_time_readable( '12:00 pm' ), '12:00' );

done_testing();

## 72 chars ############################################################
## Just split so slightly more readable and fits on 72 char lines

sub fun_time { $_[0]=~s{(\d+):(\d+)\s*(\wm|)}{sprintf'%02d:%02d%s',
  ($1%12||($3?0:12))+('pm'eq$3?12:0),$2,$3?'':$1>11?'pm':'am'}re; }

## This is more readable version with notes...
sub fun_time_readable {
  return $_[0] =~
    s{
        ## Split into 3 parts, $1 - hours, $2 - minutes & $3 - am/pm
      (\d+) : (\d+) \s* ( \wm | )
        ## We assume all strings are valid - so we don't have to anchor
        ## at both ends or worry what the 12hr clock sufficies are
        ## am/pm & \wm is shorter than [ap]m
        ##
        ## Note if we right (\wm)? the 3rd capture variable $3 is
        ## sometimes undefined - better is to use ([ap]m|) which
        ## matches the same way but $3 is now an empty string not
        ## undefined when we have a 24 hour clock time
    }
    {
      sprintf '%02d:%02d%s',
        ( $1%12 || ($3?0:12) ) + ( 'pm' eq $3 ? 12 : 0 ),
          ## Get hour modulo 12..
          ## From 24hr to 12hr clock we need to convert 00:?? to 12:??
          ## From 12hr to 24hr clock it is pm we then need to add 12...
        $2,
          ## The minutes is the easy bit just copy..
        $3 ? '' : $1>11 ? 'pm' : 'am'
          ## If we are converting from 12hr clock the third string is
          ## empty - if not and the time is <12 we return am o/w  pm
    }rex;
}

