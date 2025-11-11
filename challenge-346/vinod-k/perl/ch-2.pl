#!/usr/bin/perl

##########################################################################
# You are given a string containing only digits and a target integer.
#
# Write a script to insert binary operators +, - and * between the digits 
# in the given string that evaluates to target integer.
##########################################################################

use strict;
use warnings;

sub add_operators_recursive {
    my ($digits, $target, $pos, $expr, $prev, $value, $result) = @_;
    if ($pos == length($digits)) {
        if ($value == $target) {
            push @$result, $expr;
        }
        return;
    }

    for my $i ($pos+1 .. length($digits)) {
        my $part = substr($digits, $pos, $i - $pos);
        next if length($part) > 1 && substr($part, 0, 1) eq '0';
        my $num = int($part);

        if ($pos == 0) {
            add_operators_recursive($digits, $target, $i, $part, $num, $num, $result);
        } else {
            add_operators_recursive($digits, $target, $i, "$expr+$part", $num, $value + $num, $result);
            add_operators_recursive($digits, $target, $i, "$expr-$part", -$num, $value - $num, $result);
            add_operators_recursive($digits, $target, $i, "$expr*$part", $prev*$num, $value - $prev + $prev*$num, $result);
        }
    }
}

sub add_operators {
    my ($digits, $target) = @_;
    my @result;
    add_operators_recursive($digits, $target, 0, "", 0, 0, \@result);
    return @result;
}

# string and target
my @examples = (
    ["123", 6],
    ["105", 5],
    ["232", 8],
    ["1234", 10],
    ["1001", 2]
);

for my $ex (@examples) {
    my ($str, $target) = @$ex;
    my @output = add_operators($str, $target);
    print "Input: \$str = \"$str\", \$target = $target\n";
    print "Output: (" . join(", ", @output) . ")\n\n";
}
