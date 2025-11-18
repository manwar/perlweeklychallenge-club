#!/usr/bin/env raku
use Int::polydiv;
use Test;

is convert-time("02:30", "02:45"), 1;
is convert-time("11:55", "12:15"), 2;
is convert-time("09:00", "13:00"), 4;
is convert-time("23:45", "00:30"), 3;
is convert-time("14:20", "15:25"), 2;

sub convert-time($source, $target)
{
    my $s = DateTime.new("1970-01-01T$source:00");
    my $t = DateTime.new("1970-01-01T$target:00");

    $t .= later(days => 1) if $t < $s;

    sum (($t - $s) div 60).polydiv(60,15,5,1)
}
