#!/usr/bin/perl

# Challenge 031
#
# Task #1
# Create a function to check divide by zero error without checking if the
# denominator is zero.

use Modern::Perl;

sub divide {
    my($num, $den) = @_;
    my $res = eval { $num / $den };
    return "division by zero trapped" if $@;
    return $res;
}

say divide(5, 2);
say divide(5, 0);
