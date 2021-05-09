#!/usr/bin/perl
# The Weekly Challenge - 019
# Task 1 Five Weekends
# Task Statement:
#   Write a script to display months 
#   from the year 1900 to 2019 where you find 5 weekends 
#   i.e. 5 Friday, 5 Saturday and 5 Sunday.
# attempt: May 09th, 2021
# from: C.-Y. Fung
# Java correspondence: FiveWeekends.java
use Time::Piece;
use strict;
use warnings;

my @months = (1, 3, 5, 7, 8, 10, 12);

sub isFridayStart {
    my $year = $_[0];
    my $month = $_[1];
    return
      Time::Piece->strptime($year."-".$month."-01", "%Y-%m-%d")
        ->day_of_week == 5;
}

for my $i (1900..2019) {
    for my $j (@months) {
        if (isFridayStart($i, $j)) {
            print Time::Piece->strptime($i."-".$j."-01", "%Y-%m-%d")
                ->strftime("%Y %B"), 
                 "\n";
        }
        # printf("%4d %2d\n", $i, $j) if isFridayStart($i, $j);
    }
}

