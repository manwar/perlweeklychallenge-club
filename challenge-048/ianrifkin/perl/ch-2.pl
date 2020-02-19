#!/usr/bin/perl
use strict;
use Date::Simple;

# Write a script to print all Palindrome Dates between 
# 2000 and 2999. The format of date is mmddyyyy. For 
# example, the first one was on October 2, 2001 as it 
# is represented as 10022001.

# Solution by ianrifkin

# Assumption: between 2000 and 2999 is from Jan 1st 2000 through the last day in 2999.

my $check_date = Date::Simple->new('2000-01-01');
my $end_date = Date::Simple->new('2999-12-31');

print "\nThe following dates from $check_date to $end_date are palindromes assuming the format mmddyyy:\n";
while ($check_date <= $end_date) {
    my $forwards = $check_date->format('%m%d%Y');
    my $backwards = reverse $forwards;
    print "$forwards (" . $check_date->format('%m-%d-%Y') . ")\n" if $forwards == $backwards;
    $check_date++
}
