#!/usr/bin/perl
use strict;
use warnings;
use feature qw/say/;
use Date::Calc qw/check_date/;

my $yyyy = 2000;
my $ymax = 3000;
while ($yyyy < $ymax) {
    my $mm = reverse(substr($yyyy, 2, 2));
    $yyyy++ and next if $mm > 12 || !$mm;
    my $dd = reverse(substr($yyyy, 0, 2));
    $yyyy++ and next if $dd > 31 || !$dd;
    
    say "$mm$dd$yyyy is a palindrome" if check_date($yyyy, $mm, $dd);
    
    $yyyy++;
}
