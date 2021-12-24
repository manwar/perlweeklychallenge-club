use strict;
use warnings;
use feature "say";

sub combine {
    my @seq = @_;
    my $min = $seq[-1];
    my @comb_sums;
    for my $i (0..$#seq) {
        for my $j (0..$i-1) {
            my $sum =  $seq[$i] + $seq[$j];
            next if $sum <= $min;
            push @comb_sums, $sum;
        }
    }
    return sort { $a <=> $b } @comb_sums;
}

sub ulam {
    my @sequence = @{$_[0]};
    for (1..10) {
        my @sums = combine @sequence;
        my $last = 0;
        for my $i (0..$#sums) {
            next if $sums[$i] == $last;
            push @sequence, $sums[$i] and last if $i >= $#sums;
            $last = $sums[$i] and next if $sums[$i] == $sums[$i+1];
            push @sequence, $sums[$i] and last;
        }
    }
    return @sequence;
}
for my $test ([1,2], [2,3], [2,5]) {
    say "@$test => ", join " ", ulam $test;
}
