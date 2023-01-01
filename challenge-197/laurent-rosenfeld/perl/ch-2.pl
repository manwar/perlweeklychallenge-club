use strict;
use warnings;
use feature qw/say/;

sub wiggle_sort {
    my @in = @_;
    for my $i (0..$#in - 1) {
        if ($i % 2) {
            @in[$i, $i+1] = @in[$i+1, $i]
                if $in[$i] < $in[$i+1];
        } else {
            @in[$i, $i+1] = @in[$i+1, $i]
                if $in[$i] > $in[$i+1];
        }
    }
    return @in;
}
for my $test ([<1 5 1 1 6 4>], [<1 3 2 2 3 1>],
    [<8 12 11 13 9>], [<1 2 3 4 5 6 7>]) {
    say "@$test \t=> ", join " ", wiggle_sort @$test;
}
