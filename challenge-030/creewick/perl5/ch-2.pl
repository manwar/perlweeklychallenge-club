#!/usr/bin/perl
use strict;
use warnings;
use v5.10;

# Here you can vary the numbers count in series and the required sum

my $REQUIRED_SUM = 12;
my $NUMBERS_COUNT = 3;

# And define whether current series fits the conditions or not

sub isGoodSeries {
    my (@numbers) = @_;
    my ($sum, $evensCount) = (0, 0);

    foreach (@numbers) {
        $sum += $_;
        if ($_ % 2 == 0) {
            $evensCount++;
        }
    }

    return $sum == $REQUIRED_SUM && $evensCount > 0;
}

sub checkAllSeries {
    my @series = @_;
    my $count = @series;

    if ($count == $NUMBERS_COUNT) {
        if (isGoodSeries(@series)) {
            say "@series";
        }
    } else {
        for my $i (1..$REQUIRED_SUM) {
            my @newSeries = @series;
            push(@newSeries, $i);
            checkAllSeries(@newSeries);
        }
    }
}

checkAllSeries(());