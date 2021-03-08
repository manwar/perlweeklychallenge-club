#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;

is( year_name( 2017 ), 'Yin Fire Rooster' );
is( year_name( 1938 ), 'Yang Earth Tiger' );

done_testing();

sub year_name {
  return join q( ),
    qw(Yang Yin)[$_[0]%2],
    qw(Metal Metal Water Water Wood Wood Fire Fire Earth Earth)[$_[0]%10],
    qw(Monkey Rooster Dog Pig Rat Ox Tiger Rabbit Dragon Snake Horse Goat)[$_[0]%12],
}

