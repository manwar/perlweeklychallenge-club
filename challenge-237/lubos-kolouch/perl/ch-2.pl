use strict;
use warnings;
use Test::More tests => 2;

sub maximise_greatness {
    my @nums = @_;
    
    # Sort the array
    my @sorted_nums = sort { $a <=> $b } @nums;
    
    my $greatness = 0;
    
    for my $num (@nums) {
        # Find the first element in sorted_nums that is greater than num
        for my $i (0..$#sorted_nums) {
            if ($sorted_nums[$i] > $num) {
                $greatness++;
                splice(@sorted_nums, $i, 1);
                last;
            }
        }
    }
    return $greatness;
}

is(maximise_greatness(1, 3, 5, 2, 1, 3, 1), 4, 'Test Case 1');
is(maximise_greatness(1, 2, 3, 4), 3, 'Test Case 2');
