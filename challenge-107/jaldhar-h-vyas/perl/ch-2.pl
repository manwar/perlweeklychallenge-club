#!/usr/bin/perl

package Calc
{
     use strict;
     use warnings;

     sub new { bless {}, shift; }
     sub add { }
     sub mul { }
     sub div { }
     1;
}
package main;
use 5.020;
use warnings;

for my $key (sort keys %Calc::) {
    say $key;
}