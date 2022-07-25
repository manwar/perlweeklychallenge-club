#!/usr/bin/env raku

use lib '../lib';
use Date::WDOM;
use Test;
plan 67649;

my $day-names = flat (Any, < Monday Tuesday Wednesday Thursday Friday Saturday Sunday >);

my $ordinals = flat (Any, < First Second Third Fourth Fifth >); 

my $dt = Date.new(:1900year, :1month, :1day);

for ^55000
{
    is Date::WDOM.new(weekday-of-month => $dt.weekday-of-month, 
                      day-of-week      => $dt.day-of-week, 
                      month            => $dt.month, 
                      year             => $dt.year).mm-dd-yyyy, $dt.mm-dd-yyyy,
                                          ($dt.mm-dd-yyyy, 
                                           $ordinals[$dt.weekday-of-month], 
                                           $day-names[$dt.day-of-week])
                                           .join(' ');

    if $dt.last-date-in-month.day - $dt.day < 7
    {
    is Date::WDOM.new(weekday-of-month => 'L', 
                      day-of-week      => $dt.day-of-week, 
                      month            => $dt.month, 
                      year             => $dt.year).mm-dd-yyyy, $dt.mm-dd-yyyy,
                                          $dt.mm-dd-yyyy ~ ' Last ' ~ 
                                          $day-names[$dt.day-of-week];
    }
    
    $dt++;
}
