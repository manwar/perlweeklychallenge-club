use strict;
use warnings;
use feature "say";

sub find_slices  {
    my @in = @_;
    my @out;
    # return [] if @in < 3;
    for my $i (0..$#in - 2) {
        my $gap = $in[$i+1] - $in[$i];
        for my $j ($i+2..$#in) {
            last if $in[$j] - $in[$j-1] != $gap;
            push @out, [@in[$i..$j]];
        }
    }
    return @out ? @out : [];
}
for my $test ([<1 2 3 4>], [<2 5>], [<3 4 5 6 8>],
              [<3 5 7 9>], [<2 5 9>]) {
    printf "%-10s => ", "@$test";
    say map "(@$_) ", find_slices @$test;
}
