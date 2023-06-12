# The Weekly Challenge 220
# Task 2 Squareful
# Brute-force approach
use v5.30.0;
use warnings;
use Math::Permutation;
use List::Util qw/all/;
use List::MoreUtils qw/pairwise/;


sub _fact {
    return 1 if $_[0] == 0;
    return $_[0] * _fact($_[0]-1);
}

sub is_perfect_sq {
    my $a = sqrt($_);
    return $a !~ /\./;
}

sub check_squareful {
    my @num = @_;
    my @num0 = @num[0..$#num-1];
    my @num1 = @num[1..$#num];
    my @x = pairwise {$a+$b} @num0, @num1;
    return all {is_perfect_sq} @x;
}

sub sqf {
    my @num = @_;
    my %ans;
    my $p = Math::Permutation->init(scalar @num);
    for (1.._fact(scalar @num)) {
        my @permuted_num = map {$num[$_-1]} $p->array;
        $ans{join ",", @permuted_num} = 1 if check_squareful(@permuted_num);
        $p->nxt;
    }
    return keys %ans;
}

say join "\n", sqf(1, 17, 8);
say "";
say join "\n", sqf(2, 2, 2);

say join "\n", sqf(10,6,3,13,12);

# Follow-up
# Is there a distinct sequence of positive integers such that it has more than 3 squareful arrangements?
# See also:
# https://math.stackexchange.com/questions/1168983/arranging-numbers-from-1-to-n-such-that-the-sum-of-every-two-adjacent-number
