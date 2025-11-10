#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

{
    my @DAYS   = map +(s/(?<!1)1$/1st/r
                       =~ s/(?<!1)2$/2nd/r
                       =~ s/(?<!1)3$/3rd/r
                       =~ s/(?<=\d)$/th/r),
                 1 .. 31;
    my @MONTHS = qw( Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec );
    my @YEARS  = 1900 .. 2100;

    my %DAYS;
    @DAYS{@DAYS} = ();
    my $m = 1;
    my %MONTHS = map +($_ => $m++), @MONTHS;
    my %YEARS;
    @YEARS{@YEARS} = ();

    sub format_date($str) {
        my ($day, $month, $year) = split / /, $str;
        if (   exists $DAYS{$day}
            && exists $MONTHS{$month}
            && exists $YEARS{$year}
        ) {
            return sprintf '%s-%02d-%02d', $year,
                                           $MONTHS{$month},
                                           $day =~ /([0-9]+)/
        }
        die "Date invalid or out of range: $str.\n"
    }
}

use Test2::V0;
plan(5 + 1 + 5);

is format_date('1st Jan 2025'), '2025-01-01', 'Example 1';
is format_date('22nd Feb 2025'), '2025-02-22', 'Example 2';
is format_date('15th Apr 2025'), '2025-04-15', 'Example 3';
is format_date('23rd Oct 2025'), '2025-10-23', 'Example 4';
is format_date('31st Dec 2025'), '2025-12-31', 'Example 5';

is format_date('12th Dec 1900'), '1900-12-12', 'No 12nd';

for my $invalid ('11st Apr 2020', '12nd Apr 2020', '0th Apr 2000',
                 '1st Jan 2101', '31st Dec 1899'
) {
    is dies { format_date($invalid) },
        "Date invalid or out of range: $invalid.\n",
        "Invalid $invalid";
}
