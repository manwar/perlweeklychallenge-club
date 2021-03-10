#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;

## Slight extension - include the Yin/Yang prefix...

is( year_name( 2017 ), 'Yin Fire Rooster' );
is( year_name( 1938 ), 'Yang Earth Tiger' );

done_testing();

## Choose the order based on what would happen in years "0","60" -
## this is "Yang Metal Monkey", so we make them the first entry in
## the list - saves us doing a "shift" to get the right modulus key.

## We have added in the last "classifier" - Yang/Yin which split the
## element entry in two.

sub year_name {
  return join q( ),
    qw( Yang   Yin                             )[  $_[0]    %  2 ],
    qw( Metal  Water   Wood   Fire  Earth      )[ ($_[0]/2) %  5 ],
    qw( Monkey Rooster Dog    Pig   Rat   Ox
        Tiger  Rabbit  Dragon Snake Horse Goat )[  $_[0]    % 12 ];
}

