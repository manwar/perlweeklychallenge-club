#!/usr/bin/perl
# The Weekly challenge - Perl & Raku Week 084
# Task 1 Reverse Integer
# 
# Description: The number 2,147,483,647 is the 
# maximum positive value for a 32-bit signed binary integer in computing.
#
# additional info from books:
# minimum value for a 32-bigt signed binary integer: -2147483648

use strict;
use warnings;
#use Test::More tests => 4;

# 8463847412
# 2147483648
# 9876543210 

my @r_MAXPOS = split "", "2147483647";
my @r_MAXNEG_WO_SIGN = split "", "2147483648";

if ($ARGV[0] ne "") {
    print(ri($ARGV[0]), "\n");
} 
else {
    print -1_000_000, "\n";
    print(ri(-1_000_000) ,"\n") ; #should it be -000_000_1 or -1 ?
}

sub compare_digits {
    my @indvar = @{$_[0]};
    my @bigbro = @{$_[1]};
    return 0 if scalar @indvar > 10;
    return 1 if scalar @indvar < 10;
    for (0..9) {
        return 0 if $indvar[$_] > $bigbro[$_];
    }
    return 1;
}


sub ri {
    my @arr = split "" , $_[0];
    my $sgn = "+";
    $sgn = shift @arr if $arr[0] eq '-' ;
    my @r_arr = reverse @arr;
    if ($sgn eq '+') {
        if (compare_digits([@r_arr], [@r_MAXPOS])) {
            return join "",  @r_arr;
        }
        else {
            return 0;
        }
    } 
    else {
        if (compare_digits([@r_arr], [@r_MAXNEG_WO_SIGN])) {
            return '-'.(join "", @r_arr);
        }
        else {
            return 0;
        }
    }
    
}

=pod
ok ri(1234) == 4321, "example 1";
ok ri(-1234) == -4321, "example 2";
ok ri(1231230512) == 0, "example 3";
ok ri(7_463_847_412) == 2_147_483_647, "max 32-bit integer";
=cut

