#!/usr/bin/perl
# The Weekly Challenge 162
# Task 1 ISBN-13
# Usage: $ ch-1.pl [ISBN-13]
#   or   $ ch-1.pl xxx-xxx-xxxxx-x-?
use v5.22.0;
use warnings;
use List::Util qw/sum pairmap first/;

if (defined($ARGV[0])) {
    my $code = $ARGV[0];
    if (substr($code, -1, 1) eq "?") {
        say lookup($code);
    }
    else {
        say valid($code) ? "Correct check digit." 
                         : "Incorrect check digit.";
    }
}



sub lookup {
    my $partial_code = $_[0];
    return first {valid($partial_code.$_)} (0..9);
}

sub valid {
    my $code = $_[0];
    my @d = grep { /\d/ } split "", $code;
    die "Invalid ISBN-13 code!\n" if scalar @d != 13;
    return !( ($d[12] + sum pairmap {$a + 3*$b} @d[0..11]) % 10);
}



use Test::More tests => 5;
ok valid("978-0-306-40615-7"), "task example";
ok valid("978-1-492-04503-8"), "Think Julia";
ok valid("978-1-59327-666-9"), "How Software Works";
ok valid("978-1-260-08450-4"), "Database System Concepts";
ok !valid("123-4-567-89123-4"), "random strings of digits";
