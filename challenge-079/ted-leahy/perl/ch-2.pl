# # Trapped Rain Water # #
# You are given an array of positive numbers @N.
# Write a script to represent it as Histogram Chart and find out how much 
# water it can trap.
# #

use strict;
use warnings;
use feature 'say';

use List::Util qw(min max);

my @N = @ARGV;

print_histogram(@N);

my $total_trapped_water = amount_of_trapped_water(@N);
say "\nTotal amount of trapped water: $total_trapped_water";

sub print_histogram {
    my (@N) = @_;

    my @y_axis = reverse (1..max(@N));

    foreach my $y_value (@y_axis) {
        print "$y_value ";

        foreach my $x_value (@N) {
            print $y_value <= $x_value ? '#' : ' ';
            print ' ';
        } 

        print "\n";
    }

    say '- ' x scalar @N + 1;
    say '  ' . join(' ', @N);
}

# take the first number, then walk along the array until you find a number
# that's greater than or equal to it.
# then take all the numbers in between them, and for each one:
#   subtract that from the second number,
#   add that to $total_rain_units
# keep going until you reach the end of the array

sub amount_of_trapped_water {
    my (@N) = @_;

    my $total_rain_units = 0;
    my $left_col_index = 0;
    
    for my $i (0..$#N) {
        my $current_col = $N[$i];
        my $left_col = $N[$left_col_index];
    
        if ($current_col >= $left_col) {
            my $smaller_side = min($left_col, $current_col);
        
            foreach ($left_col_index+1..$i-1) {
                $total_rain_units += ($smaller_side - $N[$_]);
            }
        
            $left_col_index = $i; 
        }
    }

    return $total_rain_units
}

1;