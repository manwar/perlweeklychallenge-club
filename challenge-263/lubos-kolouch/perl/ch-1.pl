use strict;
use warnings;

sub find_target_indices {
    my ($ints, $k) = @_;
    my @sorted_with_indices = sort { $ints->[$a] <=> $ints->[$b] } 0..$#$ints;
    my @target_indices = grep { $ints->[$sorted_with_indices[$_]] == $k } 0..$#sorted_with_indices;
    return \@target_indices;
}

# Test cases
my @result1 = @{find_target_indices([1, 5, 3, 2, 4, 2], 2)};
print "Result 1: @result1\n";  # Should output: Result 1: 1 2

my @result2 = @{find_target_indices([1, 2, 4, 3, 5], 6)};
print "Result 2: @result2\n";  # Should output: Result 2: 

my @result3 = @{find_target_indices([5, 3, 2, 4, 2, 1], 4)};
print "Result 3: @result3\n";  # Should output: Result 3: 4
