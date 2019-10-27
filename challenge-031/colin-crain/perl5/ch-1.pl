#! /opt/local/bin/perl
#
#       divide_by_zero.pl
#
#       PWC31 - 1
#
#       Task #1
#           Create a function to check divide by zero error without checking if the denominator is zero.
#
#       functional programming pardigms are fun
#
#       colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";

## ## ## ## ## MAIN

my ($n, $d) = @ARGV;

unless (defined $n && defined $d) { say "usage ./divide_by_zero numerator denominator"; exit};

## from the beginning:
##      matches maybe a digit,
##      then maybe a decimal,
##      then maybe not a digit if we matched before the decimal
##      or necessarily a digit if there were no digits before
##      so 0.5, .5 and 5. all are recognized as valid input
##      but neither 2.2.5 nor . are valid
my $regex = '^(\d*)\.?(?(1)\d*|\d+)$';
unless ($n =~ /$regex/ && $d =~ /$regex/ ) { say "arguments must be numbers"; exit };

say divide_safe( $n, $d );

sub divide_safe {
## safe division function
## given input n, d returns n/d
## if d = 0, returns NAN (Not A Number)
    my ($numerator, $denominator) = @_;
    my $result;
    eval {$result = $numerator/$denominator};

    if( $@ ){
        return "NAN";
    }
    else {
        return "$result";
    }

}


