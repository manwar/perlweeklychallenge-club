#!/usr/bin/perl
use warnings;
use strict;
use 5.010;

sub isLeap {
    my ($year) = @_;
    return $year % 4  == 0 && ($year % 100 != 0 || $year % 400 == 0);
}

sub isValidDate {
    my ($year, $month, $day) = @_;

    if ($month == 2 && $day > (isLeap($year) ? 29 : 28)) {
        return undef;
    }

    if ((grep { $month == $_ } ( 4, 6, 9, 11 )) && $day > 30) {
        return undef;
    }

    return 1;
}

my $input = shift // q{};

if ($input =~ m{
    \A
    (?<century> [12])
    (?<year> [0-9]{2})
    (?<month> (0[1-9]) | (1[0-2]) )
    (?<day> (0[1-9]) | ([1-2][0-9]) | (3[01]))
    \z
}gmx) {
    my $year = (($+{century} == 1) ? 20 : 19) . $+{year};
    if (isValidDate($year, $+{month}, $+{day})) {
        say join q{-}, ($year, $+{month}, $+{day});
        exit;
    }
}

say 'Invalid date.';