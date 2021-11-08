#!/usr/bin/env raku

say workdays(2021);
say workdays(2020);

sub workdays($year)
{
    my $dt = Date.new($year, 1, 1);
    my $days = $dt.is-leap-year ?? 366 !! 365;

    for 1..$days
    {
        state $bd++ if $dt.day-of-week ~~ 1..5;
        $dt .= later(:1days);
        LAST { return $bd }
    }
}
