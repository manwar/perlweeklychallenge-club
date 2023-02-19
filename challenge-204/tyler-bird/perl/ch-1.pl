package main;

use strict;
use warnings;

sub monotonic
{
        my @values = @_;

        my $current_value = shift(@values);

        my $was_increase = 0;
        my $was_decrease = 0;

        foreach my $value ( @values ) {
                if($value > $current_value && $was_decrease) {
                        return 0;
                } elsif($value < $current_value && $was_increase) {
                        return 0;
                } else {
                        if($value > $current_value ) {
                                $was_increase = 1;
                        } elsif($value < $current_value) {
                                $was_decrease = 1;
                        }

                        $current_value = $value;
                }
        }

        return 1;
}

print monotonic(1,2,2,3) . "\n";
print monotonic(1,3,2) . "\n";
print monotonic(6,5,5,4) . "\n";


1;
