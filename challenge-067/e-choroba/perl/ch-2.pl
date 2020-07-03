#!/usr/bin/perl
use warnings;
use strict;

my %keyboard = (2 => [qw[ a b c   ]],
                3 => [qw[ d e f   ]],
                4 => [qw[ g h i   ]],
                5 => [qw[ j k l   ]],
                6 => [qw[ m n o   ]],
                7 => [qw[ p q r s ]],
                8 => [qw[ t u v   ]],
                9 => [qw[ w x y z ]]);

sub expand {
    my (@digits) = @_;
    if (@digits == 1) {
        return @{ $keyboard{ $digits[0] } }
    } else {
        return map {
            my $d = $_;
            map $d . $_, expand(@digits[1 .. $#digits])
        } @{ $keyboard{ $digits[0] } }
    }
}

sub digits2words {
    my ($number) = @_;
    return expand(split //, $number)
}

use Test::More tests => 1;
is_deeply [digits2words('35')],
     ["dj", "dk", "dl", "ej", "ek", "el", "fj", "fk", "fl"];
