#!/usr/bin/env perl

# The Weekly Challenge 259 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-259/
#
# Task 1 - Banking Day Offset
#

use strict;
use warnings;
use v5.28;
use List::Util qw/any/;
use DateTime;
use Data::Dump qw(dump);

my @examples = ( '2018-06-28', '2018-06-28' );
my @examples_offset = ( 3, 3 );
my @examples_bank_holidays = (
           ['2018-07-03'],
);

sub banking_day_offset {
    my ($start_date, $offset, $bank_holidays) = @_;
    my $day_offset = DateTime->new(
            year  => substr($start_date, 0, 4), 
            month => substr($start_date, 5, 2), 
            day   => substr($start_date, 8, 2)
        );

    for (my $i = 1; $i <= $offset; $i++) {
        $day_offset->add(days => 1);

        $day_offset->add(days => 1) while ($day_offset->day_of_week =~ /[67]/);

        $day_offset->add(days => 1) if (any {$day_offset->ymd eq $_} @$bank_holidays);


    }
    
    return $day_offset->ymd;
}

for (my $i = 0; $i < scalar @examples; $i++) {
    my $elements = $examples[$i];
    my $offset = defined $examples_offset[$i] ? $examples_offset[$i] : 0;
    my $bank_holidays = defined $examples_bank_holidays[$i] ? $examples_bank_holidays[$i] : undef;
    my $bdo = banking_day_offset $elements, $offset, $bank_holidays;

    print 'Input : $start_date = ', $elements, ', $offset = ', $offset;
    print ', $bank_holidays = ', dump(@$bank_holidays) if (defined $bank_holidays);
    print "\n";
    say 'Output : ', $bdo;
    say ' ';
}
