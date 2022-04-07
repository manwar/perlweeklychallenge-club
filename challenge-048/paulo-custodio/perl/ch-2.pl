#!/usr/bin/env perl

# Challenge 048
#
# TASK #2
# Palindrome Dates
# Write a script to print all Palindrome Dates between 2000 and 2999. The format
# of date is mmddyyyy. For example, the first one was on October 2, 2001 as it is
# represented as 10022001.

use Modern::Perl;
use DateTime;

my $dt = DateTime->new(year=>2000, month=>1, day=>1);
while ($dt->year < 2100) {
    my $txt = $dt->strftime("%m%d%Y");
    say $txt if reverse($txt) eq $txt;  # is palindrome
    $dt->add(days=>1);
}
