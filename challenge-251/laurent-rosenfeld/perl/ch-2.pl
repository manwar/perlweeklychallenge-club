use strict;
use warnings;
use feature 'say';

sub min {
    my @in = @_;
    my $min = $in[0];
    my $min_i = 0;
    for my $i (0..$#in) {
        if ($in[$i] < $min) {
            $min_i = $i;
            $min = $in[$i];
        }
    }
    return $min_i;
}

sub lucky_number {
    my @in = @_;
    ROW_LABEL:
    for my $row (0..$#in) {
        my $min_i = min @{$in[$row]};
        my $min_val = $in[$row][$min_i];
        for my $i (0..$#in) {
            next ROW_LABEL if $in[$i][$min_i] > $min_val;
        }
        return $min_val;
    }
    return -1
}

for my $test ( [ [<3 7 8>], [<9 11 13>], [<15 16 17>] ],
      [ [<1 10 4 2>], [<9 3 8 7>], [<15 16 17 12>] ],
      [ [<7 8>], [<1 2>] ]) {

    my @gist = map { " [@$_]" } @$test;
    printf "%-40s => ", "@gist ";
    say lucky_number @$test;
}
