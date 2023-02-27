package main;

use strict;
use warnings;

print max_xor([60, 13]) . "\n";

sub max_xor
{
    my($aref) = @_;

    my $unique_href = {};

    foreach my $value (@{$aref}) {
        $unique_href->{$value} = 1;
    }

    my @unique_values = keys %{$unique_href};
    my $max = 0;

    for(my $i = 0; $i < scalar(@unique_values); $i++) {
        for(my $j = 0; $j < scalar(@unique_values); $j++) {
            my $value = int($unique_values[$i]) ^ int($unique_values[$j]);
            if($value > $max) {
                $max = $value;
            }
       }
    }

    return $max;
}


1;
