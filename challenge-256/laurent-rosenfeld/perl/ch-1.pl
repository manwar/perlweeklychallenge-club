use strict;
use warnings;
use feature 'say';

sub find_pairs {
    my @in = @_;
    my $nb_pairs = 0;
    for my $i (0..$#in) {
        for my $j ($i + 1 ..$#in) {
            $nb_pairs++ if $in[$i] eq reverse $in[$j];
        }
    }
    return $nb_pairs;
}

my @tests = ([<ab de ed bc>], [<aa ba cd ed>],
             [<uv qp st vu mn pq>]);
for my $test (@tests) {
    printf "%-20s => ", "@$test";
    say find_pairs @$test;
}
