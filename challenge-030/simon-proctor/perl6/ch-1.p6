#!/usr/bin/env perl6

use v6;

#! Print all the sunday christmases from 2019 until 2100
sub MAIN() {
    .say for (2019..2100).map( { Date.new( :year($_), :day(25), :month(12) ) } ).grep( *.day-of-week == 7 );
}
