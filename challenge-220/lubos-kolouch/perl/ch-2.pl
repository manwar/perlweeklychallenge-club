use strict;
use warnings;
use Math::Complex;
use Algorithm::Permute;

sub is_squareful {
    my @arr = @_;
    foreach my $i (0..$#arr-1) {
        my $sum = $arr[$i] + $arr[$i+1];
        my $sqrt = sqrt($sum);
        return 0 unless $sqrt == int($sqrt);
    }
    return 1;
}

sub squareful_permutations {
    my @ints = @_;
    my %results;
    my $p = Algorithm::Permute->new(\@ints);
    while (my @perm = $p->next) {
        $results{join(", ", @perm)} = \@perm if is_squareful(@perm);
    }
    return values %results;
}

# Test Cases
print join(", ", @$_), "\n" for squareful_permutations(1, 17, 8);  # 1, 8, 17 and 17, 8, 1
print join(", ", @$_), "\n" for squareful_permutations(2, 2, 2);  # 2, 2, 2
