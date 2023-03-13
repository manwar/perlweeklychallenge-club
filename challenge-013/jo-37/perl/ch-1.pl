#!/usr/bin/perl

use v5.16;
use warnings;
use Date::Manip::Recur;

say $_->printf('%Y/%m/%d')
    for Date::Manip::Recur
        ->new("last Friday of every month in $ARGV[0]")
        ->dates;
