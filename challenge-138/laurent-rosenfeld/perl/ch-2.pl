use strict;
use warnings;
use feature "say";

my ($found, $root);

sub partition {
    my ($sum, @in) = @_;
    if (scalar @in == 0) {
        $found = 1 if $sum == $root;
        return;
    }
    for my $i (1..(scalar @in)) {
        my $new_sum = $sum + join "", @in[0..($i-1)];
        last if $new_sum > $root;
        partition ($new_sum, @in[$i..$#in]);
    }
}

sub split_square {
    my $sq = shift;
    $root = int sqrt($sq);
    say "$sq is not a perfect square\n" and return 0 if $root ** 2 != $sq;
    $found = 0;
    partition(0, split //, $sq);
    return $found;
}
for my $test (qw<1 27 81 100 225 1296 6561 9801>) {
    printf "%5d\t%d\n", $test , split_square $test;
}
