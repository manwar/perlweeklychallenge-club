#!/usr/bin/env perl6

# ch-1.p6 - Weird dates. Convert Cyymmdd -> yyyy-mm-dd
#
# Ryan Thompson <rjt@cpan.org>

use v6;

sub MAIN( Int $date ) {
    $date ~~ /^
        $<cent> = [ <[12]> ]                         # Century (1:1900,2:2000)
        $<yy>   = [ \d \d  ]                         # Year    (2-digit)
        $<mm>   = [ 0<[1..9]> | 1<[012]> ]           # Month   (01..12)
        $<dd>   = [ 0<[1..9]> | <[12]>\d | 3<[01]> ] # Day     (01..31)
    $/ or die "Usage: $*PROGRAM Cyymmdd";

    my Int $yyyy = ($<cent> + 18 ~ $<yy>).Int;

    die "$yyyy-$<mm> does not have $<dd> days"
        if days-in($yyyy, $<mm>.Int) < $<dd>;

    say "$yyyy-$<mm>-$<dd>";

}

# Return the number of days in the given month (with year specified so
# we can check if it is a leap year)
sub days-in( Int $y, Int $m ) {
    my @days = (0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
    @days[2]++ if leap-year($y);
    @days[$m];
}

# Return true if year is a leap year
sub leap-year( Int $y ) {
    return 1 unless $y % 400;
    return 0 unless $y % 100;
    return 1 unless $y % 4;
    return 0;
}
