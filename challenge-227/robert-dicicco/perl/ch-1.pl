#!/usr/bin/env perl
=begin comment
-------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-07-24
Challenge 227 Task 1 Fridat 13th ( Perl )
-------------------------------------
=cut
use v5.38;
use strict;
use warnings;
use Date::Calc qw/Day_of_Week/;

if (($#ARGV == -1) or ($ARGV[0] < 1753 or $ARGV[0] > 9999)) {
    say "Please supply a year between 1753 and 9999";
    exit;
}
my $year = $ARGV[0];
my $month = 1;
my $day = 1;
while ($month <= 12){
    my $dow = Day_of_Week($year,$month,13);
    if ($dow == 5) {
        say "$year $month 13 : was a Friday";
    }
    $month++;
}

=begin comment
-------------------------------------
SAMPLE OUTPUT
perl .\Friday13.pl 2023

2023 1 13 : was a Friday
2023 10 13 : was a Friday

perl .\Friday13.pl 1753

1753 4 13 : was a Friday
1753 7 13 : was a Friday
-------------------------------------
=cut


