#!/usr/bin/env perl6
use v6;

sub extract_date($str) {
    $str ~~ /^(1 || 2) (\d ** 2) ((0(<[1..9]>)) || (1(0 || 1 || 2))) (\d ** 2)/;

    (! $/.[0,1,2,3].all) && return "Malformed date string";

    my $year=((($/.[0] ~~ 1) ?? ('20') !! ('19')) ~  $/.[1].Str).Int;
    my ($month,$day)=$/.[2,3].map(*.Int);

    ($day !~~ 1..(Date.new($year,$month,1).last-date-in-month.day)) && return "Malformed date string";

    return qq|{$year}-{sprintf("%02d",$month)}-{$day}|;
}

say extract_date(@*ARGS[0])
