#!/usr/bin/perl

use v5.16;
use warnings;
use Date::Manip::Recur;

# Select the years where 25 Dec is Sunday.
say $_->printf('%Y') for grep $_->printf('%w') == 7,
    Date::Manip::Recur->new("*2019-2100:12:0:25:0:0:0")->dates;

