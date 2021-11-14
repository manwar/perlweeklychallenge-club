#!/usr/bin/perl
use 5.020;
use warnings;

sub p {
    my ($year) = @_;
    return (($year + int($year / 4) - int($year / 100) +  int($year / 400)) % 7);
}

sub isLongYear {
    my ($year) = @_;
    return (p($year) == 4 || p($year - 1) == 3); 
}

say join q{, }, grep { isLongYear($_); } (1900 .. 2100);
