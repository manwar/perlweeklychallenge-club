#!/usr/bin/perl
#Create a function to check divide by zero error 
#without checking if the denominator is zero.
use strict;
use warnings;
use feature 'say';

sub div_zero_check {
    my @div =  @_;
    my $r   =  eval "$_[0]/$_[1]";
    $@      =~ /z/ ? -1 :$r ;
} 
my $r;
say ( (($r = div_zero_check(112,0)) < 0) ? "Division by zero detected" : $r );
say ( (($r = div_zero_check(0,0))   < 0) ? "Division by zero detected" : $r );
say ( (($r = div_zero_check(0,1))   < 0) ? "Division by zero detected" : $r );
say ( (($r = div_zero_check(32,12)) < 0) ? "Division by zero detected" : $r );

