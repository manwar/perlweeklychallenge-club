#!/usr/bin/perl

use strict;
use warnings;

my $leapDay         = '0229';
my ($minYr, $maxYr) = (2000, 2999);
my @palDates        = ();

my $mm = '01';
my $dd = '01';

while ($mm < 13) {
    my $yr = validYear("$mm$dd");

    if ($yr) {
        push @palDates, "$mm$dd$yr";
    }

    incr(\$dd);

    if (monthLength($mm) < $dd) {
        # special leap case
        if ("$mm$dd" eq $leapDay) {
            my $yr = validYear($leapDay);

            if (isLeap($yr)) {
                push @palDates, "$leapDay$yr";
                warn "LEAP! $mm$dd$yr\n\n";
            }
        }

        # roll monthy/day
        incr(\$mm);
        $dd = '01';
    }
}

foreach my $dt (sort { yyyymmdd($a) <=> yyyymmdd($b) } @palDates) {
    print $dt . "\n";
}

sub incr { # zero-padded increment
    ${$_[0]} = sprintf '%02d', ${$_[0]} + 1;
}

sub isLeap { # doesn't merit datetime
    my ($year) = @_;

    return $year && (!($year % 4) && (!!($year % 100) || !($year % 400)));
}

sub monthLength { # nucks (we don't need datetime...)
    my $mm    = sprintf '%02d', $_[0];
    my $moLen = 31;

    if ($mm == 2) {
        $moLen = 28;
    } elsif ($mm =~ /^(?:04|06|09|11)$/) {
        $moLen = 30;
    }

    return $moLen;
}

sub validYear { # palindrome test
    my $yr = join('', reverse split('', $_[0]));

    if (
           $yr >= $minYr
        && $yr <= $maxYr
    ) {
        return $yr;
    }
}

sub yyyymmdd { # for sorting output
    return substr($_[0], 4, 4) . substr($_[0], 0, 4);
}
