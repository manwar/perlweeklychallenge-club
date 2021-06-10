#! /usr/bin/env perl

use strict;
use warnings;

use feature 'say';
use Math::BigInt;

my $str = 'A';
my $int = 1299;
my @array = qw/A 1299/;


say get_int_value(\$str);
say get_int_value(\$int);
say get_int_value(\@array);

sub get_int_value
{
    my $string = shift;
    $string =~ /(0x[a-f\d]+)/;
    return hex($1);
    return Math::BigInt->new($1);
}


say hex("0x55ac8143d358");
say Math::BigInt->new("0x55ac8143d358");
