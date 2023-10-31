use strict;
use warnings;

sub count_arithmetic_triplets {
    my ($nums_ref, $diff) = @_;
    my @nums = @{$nums_ref};
    my $count = 0;
    my %nums_set = map { $_ => 1 } @nums;

    for my $num (@nums) {
        if (exists $nums_set{$num + $diff} && exists $nums_set{$num - $diff}) {
            $count++;
        }
    }

    return $count;
}

# Test Cases
print count_arithmetic_triplets([0, 1, 4, 6, 7, 10], 3);  # Should print 2
print "\n";
print count_arithmetic_triplets([4, 5, 6, 7, 8, 9], 2);  # Should print 2
print "\n";
