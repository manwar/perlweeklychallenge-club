#!/usr/bin/perl -w
use warnings;
use strict;
use feature 'say';
use File::Slurp 'read_file';

# Task 2: Hot Day
# You are given file with daily temperature record in random order.
# Write a script to find out days hotter than previous day.

# It is assumed that we are given consecutive days
# It is assumed that we are given month and day in \d{2} format
# It is assumed that format of the file is correct


sub order
{
    my @rawData = read_file('temperature.txt');
    my @storage;

    foreach my $line (@rawData)
    {
        # we are not trying to catch only digits at the temp, if the temperature is negative catch it as well
        my ($year, $month, $day, $temp) = ($line =~ /(\d{4})-(\d{2})-(\d{2}),\s*(.*)/); 

        # store things
        my %temphash;
        $temphash{date}       = $year.$month.$day;
        $temphash{temp}       = $temp;
        $temphash{stringDate} = "$year-$month-$day";
        
        # store the temporary hash
        push(@storage, \%temphash);
    }


    my $lastTemp;
    
    # sort the array by the dates
    foreach my $elem ( sort {$a->{date}  <=> $b->{date} } @storage)
    {
        my $currentTemp = $elem->{temp};

        #check if the previous day's temperature is greater than the current temperature
        if( (defined $lastTemp) && ($lastTemp < $currentTemp))
        {
            # print out the date
            say($elem->{stringDate});
        }

        # store the temperature for the next element
        $lastTemp = $currentTemp;
    }

}
