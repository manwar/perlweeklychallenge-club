#!/bin/env perl
# You are given file with daily temperature record in random order.
# Write a script to find out days hotter than previous day.
# Example:
#
# Input File: (temperature.txt)     Output:
# 
# 2022-08-01, 20                    2022-08-02
# 2022-08-09, 10                    2022-08-05
# 2022-08-03, 19                    2022-08-06
# 2022-08-06, 24                    2022-08-08
# 2022-08-05, 22                    2022-08-10
# 2022-08-10, 28
# 2022-08-07, 20
# 2022-08-04, 18
# 2022-08-08, 21
# 2022-08-02, 25

use v5.36;
use strict;
use warnings;

use Time::Piece;
use Time::Seconds;

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

my %tempData;
while (<>)
{
    chomp;
    my ($day, $temp) = split /, /;
    $tempData{$day} = $temp;
}


sub findTempIncrease($tempData)
{
    my @tempHistory;
    my @tempIncrease;
    my $dayIndex = 0;
    for my $day (sort keys %$tempData )
    {
        $tempHistory[$dayIndex] = { date => $day, temp => $tempData->{$day} };
        $dayIndex++;
    }

    my ($prevDay, $nextDay) = (0, 1);
    while ( $nextDay < @tempHistory )
    {
        my $prevTemp = $tempHistory[$prevDay]->{temp};
        my $nextTemp = $tempHistory[$nextDay]->{temp};

        push @tempIncrease, $tempHistory[$nextDay]->{date} if ( $nextTemp > $prevTemp );
        $prevDay++;
        $nextDay++;
    }

    return \@tempIncrease;
}


sub runTest
{
    my @TestCase = (
        { data => { "2022-08-01" => 20 ,
                    "2022-08-09" => 10 ,
                    "2022-08-03" => 19 ,
                    "2022-08-06" => 24 ,
                    "2022-08-05" => 22 ,
                    "2022-08-10" => 28 ,
                    "2022-08-07" => 20 ,
                    "2022-08-04" => 18 ,
                    "2022-08-08" => 21 ,
                    "2022-08-02" => 25 ,
                  },
          result => [ "2022-08-02",
                      "2022-08-05",
                      "2022-08-06",
                      "2022-08-08",
                      "2022-08-10"
                    ]
        },
    );

    use Test::More;

    for my $tc ( @TestCase )
    {
        is_deeply( findTempIncrease( $tc->{data} ), $tc->{result} );
    }

    done_testing;
}
