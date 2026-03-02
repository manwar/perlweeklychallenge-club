#!/usr/bin/perl
use warnings;

sub remove_leading_zeros{
    my $number = shift;
    return $number * 1;

}

print remove_leading_zeros("-0000145")."\n";