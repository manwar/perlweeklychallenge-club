#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;

## Slight extension - include the Yin/Yang prefix...

is( year_name( 2017 ), 'Yin Fire Rooster' );
is( year_name( 1938 ), 'Yang Earth Tiger' );

done_testing();

## Choose the order based on what would happen in years "0"..."60" - "Yang Metal Monkey"
## is the base year there then...

## To save doing the int/2 we just

sub year_name {
  return join q( ),
    qw(Yang Yin                            )[  $_[0]    %2  ],
    qw(Metal Water Wood Fire Earth         )[ ($_[0]/2) %5  ],
    qw(Monkey Rooster Dog Pig Rat Ox
       Tiger Rabbit Dragon Snake Horse Goat)[  $_[0]    %12 ],
}

