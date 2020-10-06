#!/usr/bin/perl

use strict;
use warnings;

use feature qw(say);

use Test::More;

## Run tests....

is( "@{common_base_string( qw(abcdabcd abcdabcdabcdabcd) )}", 'abcd abcdabcd' );
is( "@{common_base_string( qw(aaa aa) )                   }", 'a' );
is( "@{common_base_string( 'abcd'x30, 'abcd'x12 )         }", 'abcd abcdabcd abcdabcdabcd abcdabcdabcdabcdabcdabcd' );
is( "@{common_base_string( qw(abcd ef) )                  }", '' );

done_testing;

sub common_base_string {
  my( $s, $t ) = @_;
  my $ls = length $s; ## need lengths many times so we get them
  my $lt = length $t;
  return [ map { substr $s,0,$_ }
          grep { my $x = substr $s,0,$_;
                  !($ls % $_) &&           ## false unless length of
                  !($lt % $_) &&           ## both strings a multiple of $_
                  $s eq ($x x ($ls/$_)) && ## check to see if both
                  $t eq ($x x ($lt/$_))    ## strings fit requirement!
               }
               1 .. ($ls<$lt?$ls:$lt) ];
}




