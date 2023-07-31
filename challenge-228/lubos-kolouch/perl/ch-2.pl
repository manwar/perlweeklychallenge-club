use strict;
use warnings;
use List::Util 'min';

sub count_operations {
    my @array = @_;
    my $count = 0;
    while (@array) {
        if ($array[0] == min @array) {
            shift @array;
        } else {
            push @array, shift @array;
        }
        $count++;
    }
    return $count;
}

print count_operations(3, 4, 2);  # Output: 5
print "\n";
print count_operations(1, 2, 3);  # Output: 3
print "\n";
