use strict;
use warnings;
use feature "say";

my @tests = ([1.2, 0.4, 0.1, 2.5],
             [0.2, 1.5, 0.9, 1.1],
             [0.5, 1.1, 0.3, 0.7],
             [0.7, 4.3, -4.1, 1.1]
            );
for my $R (@tests) {
    say "Testing: @$R";
    say test_candidates(@$R);
}
sub test_candidates {
    my @in = @_;
    for my $i (0..$#in) {
        for my $j ($i+1..$#in) {
            for my $k ($j+1..$#in) {
                my $sum = $in[$i] + $in[$j] + $in[$k];
                next if $sum < 1 or $sum > 2;
                say "@in[$i, $j, $k]";
                return 1;
            }
        }
    }
    return 0;
}
