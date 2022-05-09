use strict;
use warnings;
use feature "say";

sub combine2 {
    my @combinations;
    my @in = @_;
    for my $i (0..$#in) {
        for my $j ($i + 1 .. $#in) {
            push @combinations, [$in[$i], $in[$j]];
        }
    }
    return @combinations;
}

for my $test ([qw <1 2 3>], [qw <2 3 4>]) {
    my $sum = 0;
    $sum += $_->[0] & $_->[1] for combine2 @$test;
    say "@$test -> ", $sum;
}
