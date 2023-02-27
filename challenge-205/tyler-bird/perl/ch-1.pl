package main;

use strict;
use warnings;
use Data::Dumper;

print find_third_highest([0,1,2,3]) . "\n";     # prints 1
print find_third_highest([1,0]) . "\n";         # prints 1
print find_third_highest([5,4,0,1,2]) . "\n";   # prints 2

sub find_third_highest
{
    my($aref) = @_;

    my $max         = 0;
    my $index       = 0;

    my $max_canidates_aref = [];

    for (0 .. 2) {
        if(scalar(@{$aref})) {
            ($max, $index) = find_max($aref);
            splice(@{$aref}, $index, 1);
            push(@{$max_canidates_aref}, $max);
        }
    }

    if(scalar(@{$max_canidates_aref}) < 3) {
        ($max, $index) = find_max($max_canidates_aref);
    }

   return $max;
}


sub find_max
{
    my($aref) = @_;

    my $max = 0;
    my $index = 0;

    for(my $i = 0; $i < @{$aref}; $i++) {
        my $number = $aref->[$i];
        if($number > $max) {
            $max = $number;
            $index = $i;
        }
    }

    return ($max, $index);
}

1;
