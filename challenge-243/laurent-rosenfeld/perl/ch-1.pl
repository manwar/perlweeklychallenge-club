use strict;
use warnings;
use feature 'say';

sub count_reverse_pairs {
    my @in = @_;
    my $end = $#in;
    my $count = 0;
    for my $i (0..$end-1) {
        for my $j ($i..$end) {
            $count++ if $in[$i] > 2 * $in[$j];
        }
    }
    return $count;
}

for my $test ([qw<1 3 2 3 1>], [qw<2 4 3 5 1>]) {
    print "@$test => ";
    say count_reverse_pairs @$test;
}
