#!/usr/bin/perl

use strict;
use warnings;

use feature 'say';

no warnings 'uninitialized';

my @input_array = @ARGV;
@input_array = (5, 2, -2, 0) if scalar @ARGV == 0;
say "input numbers:  (", (join ', ', @input_array), ")";

my $array_size = scalar @input_array;

my $missing_number = findMissingNumber(\@input_array, $array_size);
say "Smallest positive number missing is: $missing_number";

sub findMissingNumber {
    my ($a, $size ) = @_;
    my @array = @$a;

    my ($val, $nextval);
    my $i = 0;

    foreach (0..$size){
        $i = $_;
        next if(($array[$i] <= 0) || ($array[$i] > $size));
        $val = $array[$i];
        while($array[$val -1] != $val){
            $nextval        = $array[$val -1];
            $array[$val -1] = $val;
            $val            = $nextval;
	    last if(($val <= 0) || ($val > $size));
        }			
    }
    foreach (0..$size){
        $i = $_;
        if ($array[$i] != $i + 1){
            return $i + 1;
        }
    }
    return $size + 1;
}
