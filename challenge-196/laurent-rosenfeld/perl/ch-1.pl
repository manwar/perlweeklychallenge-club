use strict;
use warnings;
use feature qw/say/;

sub find_132 {
    my @in = @_;
    for my $i (0..$#in) {
        my @out = ($in[$i]);
        for my $j ($i+1..$#in) {
            next unless $in[$j] > $out[0];
            my @out2 = (@out, $in[$j]);
            for my $k ($j+1..$#in) {
                if ($in[$k] > $out2[0]
                    and $in[$k] < $out2[1]) {
                    return @out2, $in[$k];
                }
            }
        }
    }
    return "()"; # no solution if we've got here
}
for my $test ( [<3 1 4 2>], [<1 2 3 4>],
               [<1 3 2 4 6 5>], [<1 3 4 2>] ) {
    say "@$test \t=> ", join " ", find_132 @$test;
}
